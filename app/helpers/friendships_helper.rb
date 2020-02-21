module FriendshipsHelper
    def friend_request?(user)
        current_user.friendships.find_by(reciever_id: user.id).nil?
    end
end
