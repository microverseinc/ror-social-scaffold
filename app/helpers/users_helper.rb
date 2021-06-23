module UsersHelper
    def request_sent?(friend)
        !current_user.friendships.where(friend_id:friend.id, confirmed: nil).empty?
    end
    def is_friend?(user)
        !!(current_user.friendships.where(user_id: current_user.id ,friend_id:user.id,confirmed: true) || current_user.friendships.where(user_id: user.id, friend_id: current_user.id, confirmed: true))
    end
    
end