class Api::V1::AuthController < Api::V1::BaseController
    skip_before_action :authenticate, only: :create

    def create
        user = User.where(email: params[:email]).first

        if user && user.valid_password?(params[:password])
            render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
        else
            render json: { message: 'Unauthorized' }, status: :unauthorized
        end
    end
end
