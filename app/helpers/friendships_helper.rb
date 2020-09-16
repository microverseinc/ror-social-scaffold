module FriendshipsHelper
  def friendship_action(current_user, user)
    render 'friendships/friendship_actions', user: user unless current_user == user
  end
end
