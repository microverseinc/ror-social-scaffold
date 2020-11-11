class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user_list = []
    @users.each do |user|
      @user_list << user if user != current_user
    end
    @user_list
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
