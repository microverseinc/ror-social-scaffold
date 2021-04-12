module FriendshipsHelper

  private

  def get_friends(current_user)
    friends = current_user.invitees.where(friendships: {status: true})
    friends = friends + current_user.inviters.where(friendships: {status: true})
  end
end
