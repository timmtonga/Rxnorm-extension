module BatchJobsHelper
  def preprocess_update(records)
    results = []
    (records || []).each do |record|
      results << { 'term': record.search_term, 'matches': record.matches, id: record.id,
                  'confirmed_match': record.confirmed_match,'status': record.display_status
      }
    end
    return results
  end
end
