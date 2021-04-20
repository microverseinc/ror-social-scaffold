# rubocop:disable Layout/LineLength
module FriendshipsHelper
  def check_friendship(friend_id)
    Friendship.where('(user_id=? and friend_id=?) or (user_id=? and friend_id=?)', current_user.id, friend_id,
                     friend_id, current_user.id).first
  end

  def friendship_link(user)
    friendship = check_friendship(user)
    if friendship.nil?
      link_to('| Add Friend',
              friendships_path(params: { friendship: { friend_id: user.id, user_id: current_user.id } }), method: :post, class: 'profile-link')
    elsif friendship.confirmed?
      content_tag(:span, '| Friend of yours', class: 'profile-link friend')
    elsif friendship.user_id == user.id
      link_to('| Accept', friendship_path(friendship.id), method: :put, class: 'profile-link') +
        link_to('| Reject', friendship_path(friendship.id), method: :delete, class: 'profile-link')
    else
      content_tag(:span, 'Pending...', class: 'profile-link pending')
    end
  end
end
# rubocop:enable Layout/LineLength
