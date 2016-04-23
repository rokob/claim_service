class SubmissionsController < ApplicationController
  def show
    @submission = Submission.find(params[:id])
  end

  # There are three ways to do this
  # 1. How I am doing it, in the controller
  # 2. Using a separate object who's sole purpose is to handle this flow of creating
  #    the submission and claim and making sure the world is in a consistent state
  #    depending on success/failure.
  # 3. Using an after create callback in the model.
  #
  # They have their pros and cons, I would most likely use route 2 in a real codebase
  # as it is a bit cleaner and tends to scale better, but with only this one real method
  # in this controller, this didn't seem like a bad place.
  def create
    submission = Submission.new(submission_params)
    unless submission.save
      render json: {errors: submmission.errors.full_messages}, status: :bad_request
      return
    end

    claim = Claim.new(
      insured_id: submission.insured_id,
      provider_id: submission.provider_id
    )
    unless claim.save
      submission.delete
      render json: {errors: claim.errors.full_messages}, status: :bad_request
      return
    end

    submission.claim = claim
    unless submission.save
      submisson.delete
      claim.delete
      render json: {errors: submmission.errors.full_messages}, status: :bad_request
      return
    end

    render json: {submission: submission.id, claim: claim.id}
  end

  private
    def submission_params
      params.require(:submission).permit(
        :insured_id,
        :provider_id,
        :services
      )
    end
end
