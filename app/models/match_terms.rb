module MatchTerms
  def self.search(job_id)
    items = SearchItem.where(job_id: job_id)

    #1. Normalize the search string
    #2. exact_matches with normalized and original search string
    #3. Do fuzzy matching on the rest.

    (items || []).each do |item|
      match(item)
    end

    job = BatchJob.find_by_job_id(job_id)
    job.status = "Complete"
    job.save
  end

  def self.match(search_item)
    em_result = exact_match(search_item.search_term)
    if em_result.blank?
      lm_result = lavenshtein_match(search_item.search_term)
      if !lm_result.blank?
        search_item.potential_matches = lm_result.join(',')
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
end