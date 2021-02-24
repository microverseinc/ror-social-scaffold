class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.where('id != ?', current_user.id).all
  end

  def show
    @pending_friendships = current_user.inverse_friendships
    @sent_friendships = current_user.friendships.unconfirmed

    # @friends = current_user.friendships.confirmed + current_user.inverse_friendships.confirmed

    # This array is made up of user.name from inverse_friendships and friend.name from

    # @friends_array = current_user.all_friends
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent

    @inverse_friends = current_user.inverse_friendships.confirmed.map(&:user)
    @friends = current_user.friendships.confirmed.map(&:friend)

    # @friends = (@inverse_friends + @friends).compact
    # @friends = all_friends
  end
end
