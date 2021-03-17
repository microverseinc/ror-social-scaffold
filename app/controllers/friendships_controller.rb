class FriendshipsController < ApplicationController
 

  def create
    # request(current_user, @friend)
    flash[:notice] = "Friend request has been sent #{user.name}."
    redirect_to users_path
  end
 

  private

  def user
    @friend = User.find(params[:user_id])
  end

  

end