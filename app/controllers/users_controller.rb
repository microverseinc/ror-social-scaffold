class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @all_my_pending = Friendship.all_received_of_status(@user, Friendship::PENDING) if @user == current_user
    @posts = @user.posts.ordered_by_most_recent
  end

  def invite
    receiver = User.find(params[:receiver])
    invitation = current_user.invitations.build(friend: receiver)
    invitation.save!
    redirect_back fallback_location: root_path
  end

  def accept
    sender = User.find(params[:sender])
    friendship = current_user.friendships.where(user: sender)
    friendship.first.accept
    redirect_back fallback_location: root_path
  end

  def reject
    sender = User.find(params[:sender])
    friendship = current_user.friendships.where(user: sender)
    friendship.first.reject
    redirect_back fallback_location: root_path
  end
end
