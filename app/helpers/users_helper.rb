module UsersHelper
  # rubocop:disable Style/InverseMethods
  def all_users
    users = User.select { |x| x.id != current_user.id }
    users
  end
  # rubocop:enable Style/InverseMethods

  def gravatar_for(user, size: 60)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
