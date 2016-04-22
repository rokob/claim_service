class ApplicationController < ActionController::Base
  before_action :authenticate

  private
    def authenticate
      api_key = request.headers['X-Api-Key']
      @user = User.where(api_key: api_key).first if api_key

      unless @user
        head status: :unauthorized
        return false
      end
    end

    def current_user
      @user
    end
end
