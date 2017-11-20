class MainController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.js {}
    end
  end

  def new_batch_search
    respond_to do |format|
      format.html { render :new_batch_search }
      format.js {}
    end
  end

  def summary
    respond_to do |format|
      format.html { render :index }
      format.js {}
    end
  end

  def batch_search
    #handles searching of files with list of items
    @partial = 'batch_search'
    @data = []
    CSV.foreach(params[:rxnconso][:file].path,{:headers=>:first_row}) do |row|
      @data << row[0]
    end
    respond_to do |format|
      format.html { render :index }
      format.js {}
    end
  end

  def search
    #handles searches using the main search form
    @concepts = Rxnconso.where('STR = ?', params[:rxnconso][:search])
    @concepts = Rxnconso.where('STR like ?', "%#{params[:rxnconso][:search]}%") if @concepts.blank?
    respond_to do |format|
      format.html { render :search }
      format.js {}
    end
  end

  def suggestions

    @items = Rxnconso.where("STR like ?", "%#{params[:term]}%").limit(10).collect{|x| x.STR.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }}.uniq

    render :text => @items
  end

  def search_status
    render :text => 'true'
  end

  def add
    #loads the page to new items
  end

end
