class BatchJobsController < ApplicationController
  def new

  end

  def index
    @partial = "/batch_jobs/list"
    @records = BatchJob.all.order(created_at: :desc)
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end

  def show
    @partial = "/batch_jobs/show"
    @records = SearchItem.where(job_id: params[:id], status: %w[Matched Verified])
    job = BatchJob.find(params[:id])
    @job = job.id
    @status = job.status
    @processed = job.display_processed
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end

  def create
    @partial = '/batch_jobs/show'
    new_job = BatchJob.create(batch_name: params[:batch_job][:description],status: "In Progress" )
    CSV.foreach(params[:batch_job][:file].path,{:headers=>:first_row}) do |row|
      SearchItem.create( search_term: "#{row[0]}", job_id: new_job.id, status: 'New')
    end
    respond_to do |format|
      format.html { render '/main/index' }
      format.js {}
    end
    BatchMatchJob.perform_later new_job.id
  end

  def show_update
    records = SearchItem.where(job_id: params[:id], status: %w[Matched Verified]) rescue []
    results = view_context.preprocess_update(records)
    render :text =>  results.to_json
  end
end
