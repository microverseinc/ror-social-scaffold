module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def friendship_form(user)
    friend = current_user.friend?(user)
    friend_request_sent = user.friend_requests
    if current_user.friend_requests.include?(user)
      render 'friendships/accept_cancel_request', user: user
    elsif friend
      content_tag(:span, ' Friend', class: 'profile-link')
    elsif friend_request_sent.include?(current_user)
      content_tag(:span, ' Friend request sent', class: 'profile-link')
    elsif user.id == current_user.id
    else
      render 'friendships/invite', user: user
    end
  end
end
