module FriendshipHelper
    def friend_requests(user)
        return 'You are Friends' if current_user.friend?(user)
        return 'Incoming Requests' if current_user.friend_requests.include?(user)
        return 'Waiting for response' if current_user.pending_friends.include?(user)
        create_friend(user) unless current_user.pending_friends.include?(user) || current_user.id == user
    end

    def cancel_friend(user)
    return unless current_user.friend?(user)
     link_to 'Delete', delete_friends_user_path(user), class: 'delete' 
    end

    def confirm_friends(user)
      return unless current_user.friend_requests.include?(user)
        link_to 'Accept Friend',
        confirm_friends_user_path(user), class: 'btn btn-success w-25';
    end

    def pending_friends(user)
      return unless current_user.friend_requests.include?(user)
        link_to 'Ignore ',
        delete_friends_user_path(user), class: 'btn btn-danger w-25 '
    end
    def create_friend(user)
        return if current_user.friend_requests.include?(user)
         link_to 'Request Friendship', create_friendship_user_path(user), class: 'request' 
    end
end