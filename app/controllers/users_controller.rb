class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendship = Friendship.new
    @peding_invites = Friendship.all
    @sent_invites = Friendship.where(user_id: current_user.id, confirmed: false)
    @received_invites = Friendship.where(friend_id: current_user.id, confirmed: false)
    @blank_friendship = Friendship.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    @peding_invites = Friendship.where(user_id: current_user.id,
                                       friend_id: @user.id).or(Friendship.where(friend_id: current_user.id,
                                                                                user_id: @user.id))
  end
end
