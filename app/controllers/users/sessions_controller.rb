class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    respond_to do |format|
      format.html
      format.json { render json: { message: 'You are logged in.' }, status: :ok }
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Sorry: An error has occurred.' }, status: :unauthorized
  end
end
