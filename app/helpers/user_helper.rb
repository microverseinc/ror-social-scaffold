module UserHelper
  def display_friendship_requests(_user)
    render 'friendship_requests', user: @user if current_user == @user && !current_user.who_invited_me.empty?
  end

  def display_other_user_friendship_options(user)
    return if current_user == @user

    if current_user.friend?(user)
      'Your friend'
    elsif current_user.pending_requests_sent?(user)
      'Pending'
    elsif current_user.pending_requests_received?(user)
      link_to('Accept Request | ', friendship_path(id: friendship_id(user.id, current_user.id)), method: :patch) +
        link_to('Cancel Request', destroy_friendship_path(id: friendship_id(user.id, current_user.id)), method: :delete)
    else
      link_to 'Add Friend', friendships_path(invitee_id: user.id), method: :post
    end
  end
end
