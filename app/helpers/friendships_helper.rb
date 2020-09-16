module FriendshipsHelper
  def friendship_action(current_user, user)
    # render the form only for users different from the current_user
    render 'friendships/friendship_actions', user: user unless current_user == user
  end
end
