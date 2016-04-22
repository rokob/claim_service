class ClaimsController < ApplicationController
  before_action :require_internal_user

  def show
    @claim = Claim.find(params[:id])
    render json: @claim
  end

  def update
    claim = Claim.find(params[:id])
    if claim.update(claim_params)
      head :ok
    else
      render json: {errors: claim.errors.full_messages}, status: :bad_request
    end
  end

  private
    def claim_params
      params.require(:claim).permit(:status, services: [:code, :cost, :date])
    end
end
