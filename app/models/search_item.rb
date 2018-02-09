class SearchItem < ActiveRecord::Base
  belongs_to :batch_job, foreign_key: :job_id

  def display_status
    #status can be :  new, matched, verified or added
    return self.status.titleize rescue 'Unknown'
  end

  def matches
    return self.potential_matches.split(',').length rescue 0
  end

  def confirmed_match
    if self.confirmed_matches.blank?
      return 'None'
    else
      return "#{} (#{self.confirmed_matches})"
    end

  end

end
