class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    friendships = Friendship.all
    @posts = @user.posts.ordered_by_most_recent
    @users = User.all
    @pending_requests = []
    
    friendships.each {|f| 
      @pending_requests << f.requester_id if f.requester_id != current_user.id
    }
    # puts "<<< #{user_friend_requests} >>>>"

  end
end
