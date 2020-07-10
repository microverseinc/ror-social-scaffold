class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @invers_pending = current_user.inverted_pending_friendships
    @pending = current_user.pending_friendships
    @confirmed_friendship = current_user.confirmed_friendships
    @invert_confirmed_friendship = current_user.inverted_confirmed_friendships
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @invers_pending = current_user.inverted_pending_friendships
    @pending = current_user.pending_friendships
    @confirmed_friendship = current_user.confirmed_friendships
    @invert_confirmed_friendship = current_user.inverted_confirmed_friendships
  end

  def add_friend
    friendship = current_user.friendships.build(friend_id: params[:id], confirmed: false)
    flash[:notice] = if friendship.save
                       'Friends request has been sent'
                     else
                       'Error occured during sending request please try again'
                     end
    redirect_to users_path
  end

  def accepts_friend
    mutal = current_user.inverse_friendships.find_by(user_id: params[:id])
    mutal.confirmed = true
    flash[:notice] = if mutal.save
                       'You have been accepted friendship'
                     else
                       'Error occuredto accept please try again'
                     end
    redirect_to users_path
  end

  def reject_friend
    res = Friendship.find_by(id: params[:id]).destroy
    flash[:notice] = if res
                       'Friendship request rejected Successfully'
                     else
                       'Error occuredto accept please try again'
                     end
    redirect_to users_path
  end
end
