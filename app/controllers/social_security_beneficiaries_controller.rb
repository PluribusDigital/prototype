class SocialSecurityBeneficiariesController < ApplicationController

  def show
    @data = SocialSecurityBeneficiaryService.find(params[:id])
    render :json => @data
  end

end