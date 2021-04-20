# rubocop:disable Style/InverseMethods
module UserHelper
  def all_users
    User.select { |u| u.id != current_user.id }
  end

  def gravatar_for(user, size = '32')
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def current_user_friends
    friend_list = current_user.friendships.map { |f| f.friend_id if f.status == 1 }
    friend_list += current_user.inverse_friendships.map { |f| f.friend_id if f.status == 1 }
    friend_list += [current_user.id]
    p friend_list
  end

  def requested_and_received
    requested_list = current_user.friendships.map { |f| f.friend_id if f.status.zero? }
    requested_list += current_user.inverse_friendships.map { |f| f.friend_id if f.status.zero? }
    p User.where(id: requested_list)
  end

  def friend_posts(user, _posts)
    if current_user_friends.include? user.id
      content_tag(:h3, 'Recent Posts: ') + content_tag(:ul, (render :post), class: 'posts')
    else
      content_tag(:p, "You can only see your friends posts. Click on 'Add friend' button above to invite")
    end
  end
end
# rubocop:enable Style/InverseMethods
