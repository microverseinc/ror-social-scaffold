# rubocop: disable Style/GuardClause
# rubocop: disable Layout/LineLength

module UsersHelper
  def add_button(user)
    if Friendship.where(user_id: current_user.id, friend_id: user.id, confirmed: true).exists?
      'You are friends'
    elsif Friendship.where(user_id: user.id, friend_id: current_user.id, confirmed: false).exists?
      "You have a pending friend request from #{user.name}"
    elsif Friendship.where(user_id: current_user.id, friend_id: user.id, confirmed: false).exists?
      'You already sent a request to this user'
    elsif current_user.id == user.id
      'This is your profile'
    else
      link_to('Add friend', "/friendship/#{user.id}")
    end
  end

  def accept_button(user)
    unless Friendship.where(user_id: user.id, friend_id: current_user.id, confirmed: true).exists?
      if Friendship.where(user_id: user.id, friend_id: current_user.id, confirmed: false).exists?
        link_to('Accept Friend Request', "/friendship/#{@user.id}", method: 'post') + link_to('Cancel Friend Request', "/friendship/#{@user.id}", method: 'delete')
      end
    end
  end

  def friend_request_list(user)
    @user = User.find(params[:id])
    render user.friend_requests if current_user.id == @user.id
  end

  def friend_request_title
    'Friend Requests:' if current_user.id == @user.id
  end
end

# rubocop: enable Style/GuardClause
# rubocop: enable Layout/LineLength
