class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all

    @friendship = Friendship.new
    
    # @f_request = 
    # current_user.friendships.create(params.require(:friendship)
    # .permit(:confirmer_id => 2, :requester_id => current_user.id))

    # puts "|||||| #{@f_request.confirmer_id} >>>>>>>>>>>"
  end

  def show
    @user = User.find(current_user.id)
    @show_user = User.find(params[:id])
  
    @f = Friendship.where(confirmer: @user.id)
    @i = Friendship.find_by(confirmer: @user.id)

    @posts = @show_user.posts.ordered_by_most_recent
    @users = User.all

  end
end

