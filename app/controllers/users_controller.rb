class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = current_user.potential_friends(current_user)
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def edit; end
end