module FriendshipsHelper
  def all_friends
    current_user.friends.pluck(:name)
  end
end
