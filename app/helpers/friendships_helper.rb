module FriendshipsHelper
    def friend_request?(user)
        current_user.friendships.find_by(reciever_id: user.id).nil?
    end

    def confirm?(user)
        user.friendships.find_by(reciever_id: current_user.id, status: false).nil?
    end
end
