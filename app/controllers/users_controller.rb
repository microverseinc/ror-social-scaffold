class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @current_user = User.find(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def send_req
    f = Friendship.where(user_id: current_user.id, friend_id: params[:id]).exists?
    b = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    if !f
      friend_obj = Friendship.new(user_id: current_user.id, friend_id: params[:id], confirmed: false)
      friend_obj.save
    elsif b.exists?
      b.update_all(confirmed: true)
    else
      friend_obj = Friendship.where(user_id: current_user.id, friend_id: params[:id]).select('id')
      Friendship.destroy(friend_obj.ids)
    end
    redirect_to users_path
  end
end
