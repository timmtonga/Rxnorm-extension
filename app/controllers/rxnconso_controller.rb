class RxnconsoController < ApplicationController
  def show
    @concept = Rxnconso.where("RXAUI = ? ", params[:id])
    respond_to do |format|
      format.html { render root_path }
      format.js {}
    end
  end
end
