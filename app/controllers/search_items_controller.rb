class SearchItemsController < ApplicationController
  def index
    @partial = "/search_items/list"
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end

  def show
    @partial = "/search_items/show"
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end

  def update

    term = SearchItem.find(params[:id])
    term.status = 'Verified'
    unless (params['confirmed_matches'].blank? || params['confirmed_matches'] == 'none')
      term.confirmed_matches = params['confirmed_matches']
    end
    term.save

    @partial = "/batch_jobs/show"
    @records = SearchItem.where(job_id: term.job_id, status: %w[Matched Verified])
    @job = term.job_id

    respond_to do |format|
      format.html { render '/main/index' }
      format.js {}
    end
  end

  def edit
    @partial = "/search_items/edit"
    @item = SearchItem.find(params[:id])
    @options = view_context.potential_matches(@item)
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end
end
