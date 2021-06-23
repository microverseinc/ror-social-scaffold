module UsersHelper
    def request_sent?(friend)
        !current_user.friendships.where(friend_id:friend.id, confirmed: nil).empty?
    end
    def is_friend?(user)
        !!(current_user.friendships.where(user_id: current_user.id ,friend_id:user.id,confirmed: true) || current_user.friendships.where(user_id: user.id, friend_id: current_user.id, confirmed: true))
    end

    def gravatar_for(user)
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
    
end