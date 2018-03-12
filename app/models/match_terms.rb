require 'concurrent'
module MatchTerms

  $stop_terms = ['tablet', 'capsule', 'injection', 'tab', 'ml', 'mg', 'inhalant', 'inhaler','spray', 'liquid','syrup',
                 'cream', 'foam', 'liquid cleanser', 'oil','solution','suspension','lotion','bar', 'gel', 'jelly',
                 'ointment','patch', 'powder','suppository', 'dl','iu','l','mcl','mcmol','ml','mm','mmol','mol',
                 'nmol','cm2','%','kg','g','mcg','mg','ng','kg/l','g/l','mcg/l','mg/l','ng/l','kg/ml','g/ml',
                 'mcg/ml','mg/ml','ng/ml','% w/w','% w/v','% v/v', '.', ',', '%', '+', '/', 'plus','kgl','gl','mcgl',
                 'mgl','ngl','kgml','gml','mcgml','mgml','ngml','% ww','% wv','% vv','ww','wv','vv','%ww','%wv','%vv',
                 'w/w','w/v','v/v','bp', 'usp', 'oral', 'topical', 'vaginal', 'nasal', 'ear', 'eye', 'rectal','otic',
                 'optic', 'injectable', 'ophthalmic', 'enema' ]

  def self.search(job_id)
    t1 = Time.now

    item_ids = SearchItem.where(job_id: job_id).pluck(:search_item_id)

    #1. Normalize the search string
    #2. exact_matches with normalized and original search string
    #3. Do fuzzy matching on the rest.

    cores = Concurrent.physical_processor_count
    item_ids = item_ids.in_groups((cores > 1 ? cores : 1))
    (item_ids || []).each do |id_set|
      fork do
        (id_set || []).each do |item|
          next if item.blank?
          match(item)
        end
      end
    end

    Process.waitall

    t2 = Time.now
    elapsed = time_diff_milli t1, t2

    job = BatchJob.find_by_job_id(job_id)
    job.status = "Complete"
    job.save

    puts "Started at : #{ t1}"
    puts "Finished at : #{t2}"
    puts "Time taken : #{elapsed}"
  end

  def self.match(search_item_id)
    search_item = SearchItem.find(search_item_id)

    em_result = exact_match(search_item.search_term)
    if em_result.blank?

      fz_result = fuzzy_match(search_item.search_term)
      if !fz_result.blank?
        search_item.potential_matches = fz_result.join(',')
      else
        ph_result = phonetic_match(search_item.search_term)
        search_item.potential_matches = ph_result.join(',') if !ph_result.blank?
      end
    else
      search_item.potential_matches = em_result.join(',')
      search_item.confirmed_matches = em_result.first unless em_result.length > 1
    end
    search_item.status = 'matched'
    search_item.save
  end

  def self.exact_match(item)
    w = Rxnconso.where("STR = ?",item).pluck(:RXAUI)
    return w
  end

  def self.fuzzy_match(item)
    #First check if there are brand names in the search string

    brand_name = item.match(/\[([^)]+)\]/)[1] rescue ''
    unless brand_name.blank?
      #Check first if item was created locally. Smaller set should be faster
      generic_name = item.gsub("[#{brand_name}]", '').squish
      local_terms = (LocalConcept.select(:STR, :RXAUI).where('TTY not in ("IN", "PIN") AND (STR like "%'+brand_name + '%" OR STR like "%'+ generic_name+ '%")') || [])
      possible_matches = estimate_match(item, local_terms)

      if possible_matches.blank?
        #Check next in the larger RxNORM database
        rxnorm_terms = (Rxnconso.select(:STR, :RXAUI).where('TTY not in ("IN", "PIN") and (STR like "%'+brand_name + '%" OR STR like "%'+ generic_name+'%")') || [])
        possible_matches = estimate_match(item, rxnorm_terms)
      end
      return possible_matches unless possible_matches.blank?
      item = item.gsub("[#{brand_name}]", '')
    end

    #Check partial matches in the rest of the search string
    clean_partials = chunk_term(item)
    partial_wild_cards = clean_partials.join('%" OR STR LIKE "%')

    #Again check first if item was created locally. Smaller set should be faster
    local_terms = (LocalConcept.select(:STR, :RXAUI).where('TTY not in ("IN", "PIN") AND (STR like "%'+partial_wild_cards+'%")') || [])
    possible_matches = estimate_match(item, local_terms)

    if possible_matches.blank?
      #Check next in the larger RxNORM database
      rxnorm_terms = (Rxnconso.select(:STR, :RXAUI).where('TTY not in ("IN", "PIN") AND (STR like "%'+ partial_wild_cards +'%")') || [])
      possible_matches = estimate_match(item, rxnorm_terms)
    end
    return possible_matches

  end

  def self.phonetic_match(item)
    #First check if there are brand names in the search string

    brand_name = item.match(/\[([^)]+)\]/)[1] rescue ''
    unless brand_name.blank?
      #Check first if item was created locally. Smaller set should be faster
      code = Text::Metaphone.metaphone(brand_name)
      coded_terms = (PhoneticCode.select(:RXAUI, :STR).where("(soundex like '%#{code}%')") || [])
      #coded_terms = get_related_products(coded_terms)
      possible_matches = estimate_match(item, coded_terms)

      return possible_matches unless possible_matches.blank?
    end

    clean_partials = chunk_term(item)
    partial_wild_cards = clean_partials.collect { |x| Text::Metaphone.metaphone(x) }.join("%' OR soundex LIKE '%")

    #Again check first if item was created locally. Smaller set should be faster
    coded_terms = (PhoneticCode.select(:RXAUI, :STR).where("(soundex like '%#{partial_wild_cards}%')") || [])
    #coded_terms = get_related_products(coded_terms)
    possible_matches = estimate_match(item, coded_terms)

    return possible_matches

  end

  def self.get_related_products(ingredients)
    relatives = Rxnrel.where(RXAUI1: ingredients,RELA: 'has_ingredient').pluck(:RXAUI2)
    return Rxnconso.select(:STR, :RXAUI).where(RXAUI: relatives)
  end

  def self.estimate_match(item, potential_matches)
    output = {}
    (potential_matches || []).each do |term|

      distance = Text::Levenshtein.distance(item.gsub(' ', '').downcase, term.STR.gsub(' ', '').downcase)

      if distance <= 10
        output[distance] = [] if output[distance].blank?
        output[distance] << term.aui
      end
    end

    if output.blank?
      return nil
    else
      id = output.keys.sort
      result = []
      (id || []).each do |sorted_key|
        result += output[sorted_key]
        break if result.length > 15
      end
      return result[0..15]
    end
  end

  def self.remove_stop_words(items)
    results = items - $stop_terms
    return results
  end

  def self.chunk_term(term)

    partials = replace_punctuation(term.downcase).split(' ')
    partials += term.downcase.split(' ').collect{|x| x.gsub(/[^a-z0-9]+$/i, '')}
    partials = partials.collect { |x| x.squish }.uniq
    clean_partials = remove_stop_words(partials)
    clean_partials = remove_numbers(clean_partials)
    return clean_partials.reject { |e| e.empty? }.uniq
  end
  def self.replace_punctuation(term)
    return term.gsub(/[^a-z0-9\s]/i, '')
  end

  def self.remove_numbers(partials)
    result = []
    (partials || []).each do |partial|
      partial.squish.to_f == 0.0 ? result << partial : next
    end
    return result
  end

  def self.time_diff_milli(start, finish)
    (finish - start)
  end
end