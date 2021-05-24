module UsersHelper
  def requested_user?(user)
    current_user.users_requested_ids.include?(user.id)
  end

  def requesting_user?(user)
    current_user.users_requesting_ids.include?(user.id)
  end

  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
