class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def add_friend 
    friendship = current_user.friendships.build(friend_id: params[:id], confirmed: false ) 
    if friendship.save
      flash[:notice] = "Friends request has been sent"
      redirect_to users_path
    else
      flash[:notice] = "Error occured during sending request please try again"
      redirect_to users_path
    end
  end

  def accepts_friend 
    mutal = current_user.inverse_friendships.find_by(user_id: params[:id])
    mutal.confirmed = true
    if mutal.save
      flash[:notice] = "You have been accepted friendship"
      redirect_to users_path
    else
      flash[:notice] = "Error occuredto accept please try again"
      redirect_to users_path
    end
  
  end
end
