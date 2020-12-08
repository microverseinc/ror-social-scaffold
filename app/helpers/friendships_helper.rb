module FriendshipsHelper
  
  def pending_requests
    current_user.friendships_received.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end
  
end
