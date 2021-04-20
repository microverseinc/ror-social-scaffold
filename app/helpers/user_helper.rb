module UserHelper
  def all_users
    User.reject { |u| u.id == current_user.id }
  end

  def gravatar_for(user, size = '32')
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
