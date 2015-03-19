class WmataController < ApplicationController

  def arrivals
    @arrivals = WmataService.arrivals params[:station_codes]
    render :json => @arrivals
  end

end