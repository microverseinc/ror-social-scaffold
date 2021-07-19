module FriendshipsHelper
  def new_request?(friend)
    flag = true
    request = Friendship.where(user_id: current_user.id, friend_id: friend)
    flag = request[0].confirmed unless request[0].nil?
  end
end
