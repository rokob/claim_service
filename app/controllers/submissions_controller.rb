class SubmissionsController < ApplicationController
  def show
    @submission = Submission.find(params[:id])
    render json: @submission
  end

  def create
    @submission = Submission.new(submission_params)
    unless @submission.save
      render json: {errors: @submmission.errors.full_messages}, status: :bad_request
      return
    end

    @claim = Claim.new(
      insured_id: @submission.insured_id,
      provider_id: @submission.provider_id
    )
    unless @claim.save
      @submission.delete
      render json: {errors: @claim.errors.full_messages}, status: :bad_request
      return
    end

    @submission.claim = @claim
    unless @submission.save
      @submisson.delete
      @claim.delete
      render json: {errors: @submmission.errors.full_messages}, status: :bad_request
      return
    end

    render json: {submission: @submission.id, claim: @claim.id}
  end

  private
    def submission_params
      params.permit(
        :insured_id,
        :provider_id,
        :services
      )
    end
end
