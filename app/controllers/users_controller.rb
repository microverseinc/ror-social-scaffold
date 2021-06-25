class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def my_friends
    @friendships = Friendship.where(user_id: current_user.id, confirmed: true)
    @friendships += Friendship.where(friend_id: current_user.id, confirmed: true)
    @friendships.compact
  end

  def requests
    @pending_requests = Friendship.where(user_id: current_user.id, confirmed: nil)
    @friend_requests = Friendship.where(friend_id: current_user.id, confirmed: nil)
  end
end



# friend_arr for the current_user

# def current_friends
  # 0- friend_arr = [] 
  # 1- get user friendships collection
  # 2- loop over friendships
      # check if friendship.user_id == current_user.id
        # friend_arr << User.find_by(id: friendship.friend_id)
        # else 
          # friend_arr << User.find_by(id: friendship.user_id)
        #end
# return current_friends


# friend_arr for the friend

# def user_friends(user)
  # 0- friend_arr = [] 
  # 1- get user friendships collection
  # 2- loop over friendships
      # check if friendship.user_id == user.id
        # friend_arr << User.find_by(id: friendship.friend_id)
        # else 
          # friend_arr << User.find_by(id: friendship.user_id)
        #end
# return user_friends


# def mutual_arr(current_friends,user_friends)
  # mutual_arr = current_friends & user_friends
  # return mutual_num = mutual_arr.cout


