module UserHelper
  def friendship_helper
    if current_user.id == params[:id].to_i
      nil
    elsif current_user.friend?(User.find(params[:id]))
      "You are already friends"
    elsif current_user.pending_friends.include?(User.find(params[:id]))
      "Waiting for confirmation"
    elsif User.find(params[:id]).pending_friends.include?(current_user)
      link_to 'Accept friend', friend_path, :id => params[:id]
    else
      "Send friend request"
    end
  end
end
