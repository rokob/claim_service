class ApplicationController < ActionController::Base
  before_action :authenticate
  before_action :set_default_response_format

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private
    def authenticate
      api_key = request.headers['X-Api-Key']
      @user = User.where(api_key: api_key).first if api_key

      unless @user
        head status: :unauthorized
        return false
      end
    end

    def set_default_response_format
      request.format = :json
    end

    def require_internal_user
      unless current_user.internal
        head status: :unauthorized
        return false
      end
    end

    def current_user
      @user
    end

    def not_found
      render json: {error: 'not found'}, status: :not_found
    end
end
