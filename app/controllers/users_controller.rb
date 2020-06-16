class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @f_request = @user.friendships.create(params[:confirmer_id])

    puts "|||||| #{@f_request} >>>>>>>>>>>"
  end

  def show
    @user = User.find(current_user.id)
    friendships = Friendship.all
    @f = Friendship.where(confirmer: @user.id)
    @i = Friendship.find_by(confirmer: @user.id)
    @posts = @user.posts.ordered_by_most_recent
    @users = User.all
    #@i = Friendship.find_by(invitee_id: @user)

  end
end

