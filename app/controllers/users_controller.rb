class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all_users_except_me(current_user)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def request_friendship
    target_friend = User.find(params[:id])
    new_friendship = current_user.friendships.build(friend: target_friend)
    new_friendship.save
    redirect_to :users
  end

  def accept_friendship
    friendship_sender = User.find(params[:id])
    current_user.confirm_friend(friendship_sender)
    redirect_to :users
    # friendship = Friendship.find(user: friendship_sender)
    # friendship.update(status: true)
    # friendship.save
  end

  def reject_friendship
    friendship_sender = User.find(params[:id])
    current_user.reject_friend(friendship_sender)
    redirect_to :users
  end
end
