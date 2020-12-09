module FriendshipsHelper
  def confirm_a_request(user)
    @friendship = current_user.friendships_received.find { |friendship| friendship.user == user }
    @friendship.confirmed = true
    @friendship.save
  end
end
