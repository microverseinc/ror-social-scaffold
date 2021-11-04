class Api::V1::BaseController < ApplicationController
    protect_from_forgery with: :null_session

    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  before_action :authenticate, :set_default_format

  def set_default_format
    request.format = :json
  end

  private

    def authenticate
      authenticate_user_with_token || handle_bad_authentication
    end

    def authenticate_user_with_token
      authenticate_with_http_token do |token, options|
        @user ||= User.find_by(private_api_key: token)
      end
    end

    def handle_bad_authentication
      render json: { message: "Bad credentials" }, status: :unauthorized
    end

    def handle_not_found
      render json: { message: "Record not found" }, status: :not_found
    end
end
