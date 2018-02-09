class BatchMatchJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    MatchTerms.search(args[0])
  end
end
