class BatchJobsController < ApplicationController
  def new

  end

  def index
    @partial = "/batch_jobs/list"
    respond_to do |format|
      format.html { render root_path }
      format.js {}
    end
  end

  def show

  end

  def create
    @partial = '/batch_jobs/show'
    @data = []
    CSV.foreach(params[:batch_job][:file].path,{:headers=>:first_row}) do |row|
      @data << row[0]
    end
    respond_to do |format|
      format.html { render '/main/index' }
      format.js {}
    end
  end

end
