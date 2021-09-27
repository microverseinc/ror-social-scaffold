module Api
  module V1
    class ApiController < ActionController::Base
      # before_action :check_basic_auth
      skip_before_action :verify_authenticity_token
      protect_from_forgery with: :null_session
      private
      def check_basic_auth
        unless request.authorization.present?
          head :unauthorized
          return
        end
        authenticate_with_http_basic do |email, password|
          user = User.find_by(email: email.downcase)
          if user && user.authenticate(password)
            @current_user = user
          else
            head :unauthorized
          end
        end
      end
      def current_user
        @current_user
      end
    end
  end
end