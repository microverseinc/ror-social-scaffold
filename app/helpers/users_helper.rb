module UsersHelper
    def request_sent?(friend)
        !current_user.friendships.where(friend_id:friend.id, confirmed: nil).empty?
    end
end