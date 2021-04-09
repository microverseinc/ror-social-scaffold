module FriendshipsHelper
  def get_inviter_name(inviter_id)
    User.find(inviter_id)
  end
end
