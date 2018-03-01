module MatchTerms

  $stop_terms = ['tablet', 'capsule', 'injection', 'tab', 'ml', 'mg']

  def self.search(job_id)
    items = SearchItem.where(job_id: job_id)

    #1. Normalize the search string
    #2. exact_matches with normalized and original search string
    #3. Do fuzzy matching on the rest.
    puts "Started at : #{Time.now}"
    t1 = Time.now

    (items || []).each do |item|
      match(item)
    end

    puts "Finished at : #{Time.now}"
    t2 = Time.now
    elapsed = time_diff_milli t1, t2

    job = BatchJob.find_by_job_id(job_id)
    job.status = "Complete"
    job.save
  end

  def self.match(search_item)
    em_result = exact_match(search_item.search_term)
    if em_result.blank?
      fz_result = fuzzy_match(search_item.search_term)
      if !fz_result.blank?
        search_item.potential_matches = fz_result.join(',')
      end
    else
      search_item.potential_matches = em_result.join(',')
    end
    search_item.status = 'matched'
    search_item.save
  end

  def self.exact_match(item)
    w = Rxnconso.where("STR = ?",item).pluck(:RXAUI)
    return w
  end

  def self.lavenshtein_match(item)
    return []
  end

  def self.fuzzy_match(item)
    #First check if there are brand names in the search string

    brand_name = item.match(/\[([^)]+)\]/)[1] rescue ''
    unless brand_name.blank?
      #Check first if item was created locally. Smaller set should be faster
      #local_terms = (LocalConcept.select(:STR, :RXAUI).where("STR like '%#{brand_name}%'") || [])
      #possible_matches = estimate_match(item, local_terms)

      #if possible_matches.blank?
        #Check next in the larger RxNORM database
        rxnorm_terms = (Rxnconso.select(:STR, :RXAUI).where("TTY not in ('IN', 'PIN') and (STR like '%#{brand_name}%')") || [])
        possible_matches = estimate_match(item, rxnorm_terms)
      #end
      return possible_matches unless possible_matches.blank?
    end

    #Check partial matches in the rest of the search string
    partials = replace_punctuation(item).split(' ')

    clean_partials = partials - $stop_terms
    partial_wild_cards = clean_partials.join("%' OR '%")

    #Again check first if item was created locally. Smaller set should be faster
    #local_terms = (LocalConcept.select(:STR, :RXAUI).where("STR like '%#{partial_wild_cards}%'") || [])
    #possible_matches = estimate_match(item, local_terms)

    if possible_matches.blank?
      #Check next in the larger RxNORM database
      rxnorm_terms = (Rxnconso.select(:STR, :RXAUI).where("TTY not in ('IN', 'PIN') AND (STR like '%#{partial_wild_cards}%')") || [])
      possible_matches = estimate_match(item, rxnorm_terms)
    end
    return possible_matches

  end

  def self.estimate_match(item, potential_matches)
    output = {}
    (potential_matches || []).each do |term|

      distance = Text::Levenshtein.distance(item.gsub(' ', ''), term.STR.gsub(' ', ''))

      if distance < 7
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
      return result
    end
  end

  def self.replace_punctuation(term)
    return term.gsub(/[^a-z0-9\s]/i, '')
  end

  def self.time_diff_milli(start, finish)
    (finish - start)
  end
end