module FriendshipsHelper
  def friendship
    @friendships.each do |friendship|
      return friendship if friendship.friend.id == current_user.id
    end
  end
end
