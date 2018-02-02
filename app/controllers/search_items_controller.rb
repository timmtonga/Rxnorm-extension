class SearchItemsController < ApplicationController
  def index
    @partial = "/search_items/list"
    respond_to do |format|
      format.html { render root_path }
      format.js {}
    end
  end

  def show
    @partial = "/search_items/show"
    respond_to do |format|
      format.html { render root_path }
      format.js {}
    end
  end

  def update
    @partial = "/search_items/edit"
    respond_to do |format|
      format.html { render root_path }
      format.js {}
    end
  end

  def edit
    @partial = "/search_items/edit"
    respond_to do |format|
      format.html { render root_path }
      format.js {}
    end
  end
end
