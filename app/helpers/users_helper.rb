module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def follow_form
    unless @user == current_user
      if current_user.friend?(@user)
        render 'unfollow' 
      elsif @user.pending_friends.include?(current_user) 
        render 'friendships/accept_request'
      elsif current_user.pending_friends.include?(@user)
        render 'friendships/cancel_request'
      else
      render 'follow'
      end 
    end 
  end
end
