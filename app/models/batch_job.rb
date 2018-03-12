class BatchJob < ActiveRecord::Base
  has_many :search_items, foreign_key: :job_id
  #status can be in progress or complete

  def coverage
    covered = self.search_items.where("potential_matches IS NOT NULL").count
    total = self.search_items.count
    return (covered.to_f/total)
  end

  def display_coverage
    return "#{(coverage*100).round(2)} %"
  end

  def processed
    matched = self.search_items.where(status: %w[Matched Verified]).count
    total = self.search_items.count
    return (matched.to_f/total)
  end

  def display_processed
    return "#{(processed*100).round(2)} %"
  end
end
