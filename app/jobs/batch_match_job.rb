class BatchMatchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    sleep(3.minutes)
    items = SearchItem.where(args[0])
    exact_matches = Rxnconso.where("")
    #1. do an exact search all at once and then update
    #2. Do fuzzy matching on the rest.

    (items || []).each do |item|
      exact_match(item)
    end
    job = BatchJob.find_by_job_id(args[0])
    job.status = "Matching complete"
    job.save
  end

  def exact_match(item)
    w = Rxnconso.where("STR IN (?)",item).pluck(:RXAUI)
    if !w.blank?
      csv << [item.join(','), w.collect{|x| x.RXAUI}, w.collect{|x| x.STR}]
    else
      not_found << item
    end
  end

  def lavenshtein_match(item)

  end
end
