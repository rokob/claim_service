class ClaimsController < ApplicationController
  before_action :require_internal_user

  def show
    render json: {error: 'unimplemented'}, status: :not_implemented
  end

  def update
    render json: {error: 'unimplemented'}, status: :not_implemented
  end
end
