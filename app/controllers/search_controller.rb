class SearchController < ApplicationController
  before_action :require_internal_user

  def search
    render json: {error: 'unimplemented'}, status: :not_implemented
  end
end
