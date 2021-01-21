module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def friendship_form(user)
    unless user == current_user
      if current_user.friend?(user)
        render 'unfriend',user: user  
      elsif current_user.pending_friends.include?(user) 
        render 'friendships/cancel_request',user: user 
      elsif current_user.friend_requests.include?(user)
        render 'friendships/accept_cancel_request',user: user 
      else
      render 'friendships/invite',user: user 
      end 
    end 
  end
end
