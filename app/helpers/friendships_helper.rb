module FriendshipsHelper
  def pending_friends(request)
    !current_user.friend?(request.user)
  end
end
