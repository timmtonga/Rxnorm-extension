class SearchItem < ActiveRecord::Base
  belongs_to :batch_job

  def status
    #status can be :  new, matched or verified
  end
end
