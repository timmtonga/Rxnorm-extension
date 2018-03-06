class RxnconsoController < ApplicationController
  def show
    @concept = Rxnconso.where("RXAUI = ? ", params[:id])
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end

  def ingredient_suggestion
    suggestions = Rxnconso.where("TTY in ('IN','PIN','MIN') AND STR like ?",
                                 "%#{params[:term]}%").limit(10).collect{|x| x.STR.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }}.uniq

    render :text => suggestions
  end
end
