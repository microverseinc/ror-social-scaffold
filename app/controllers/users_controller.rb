class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where( 'id != ?', current_user.id).all
  end

  def show
    @pending_friendships = current_user.inverse_friendships
    @sent_friendships = current_user.friendships
    
   # @friends = current_user.friendships.confirmed + current_user.inverse_friendships.confirmed

   #This array is made up of user.name from inverse_friendships and friend.name from 
    
    
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  
end
