module BatchJobsHelper
  def preprocess_update(records)
    results = {status: '', arrays:[]}
    (records || []).each do |record|

      results[:arrays] << [record.id,record.search_term, record.matches,record.confirmed_match,record.display_status,
                           "<a href='/local_concepts/new?id=#{record.id}' class= 'btn btn-success' data-toggle = 'modal' data-target = '#appModal' data-remote = 'true'><span class='glyphicon glyphicon-plus'></span> Add Entry</a> <a href='/search_items/#{record.id}/edit' class= 'btn btn-primary' data-toggle = 'modal' data-target = '#appModal' data-remote = 'true'><span class='glyphicon glyphicon-eye-open'></span>Verify</a>".html_safe]
    end
    results['status'] = records.first.batch_job.status
    results['progress'] = records.first.batch_job.display_processed
    return results
  end
end
