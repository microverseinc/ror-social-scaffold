class Api::V1::AuthController < Api::V1::ApiController
  skip_before_action :authenticate_user!
    protect_from_forgery with: :exception


  def create
    user = User.find_by(email: params[:email])
    if user.valid_password? params[:password]
      render json: { token: JsonWebToken.encode(sub: user.id), success: ['User logged in successfully.'] }
    else
      render json: { errors: ['Invalid email or password'] }
    end
  end
end
