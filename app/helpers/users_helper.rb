module UsersHelper
  def links_to_friendrequest(user)
    if current_user.friends.include? user
      render 'users/your_friend'
    elsif !current_user.pending_friends.select { |m| m.user == user }.empty?
      render 'users/accept_or_reject', user: user
    elsif !current_user.friend_requests.select { |m| m.friend_id == user.id }.empty?
      render 'users/sent_request'
    else
      render 'users/add_friend_button', user: user
    end
  end
end