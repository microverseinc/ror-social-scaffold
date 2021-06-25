module UsersHelper

  def request_sent?(friend)
    current_user.friendships.where(friend_id: friend.id, confirmed: nil).empty?
  end

  def is_friend?(user)
    value1 = Friendship.where(user_id: current_user.id, friend_id: user.id, confirmed: true)
    value2 = Friendship.where(user_id: user.id, friend_id: current_user.id, confirmed: true)
    value1.present? || value2.present? 
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    return image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def me?(user)
    current_user == user
  end
  
end
