module FriendshipsHelper

def verify_friendship(friend_id)
    Friendship.where('(user_id = ? and friend_id = ?) OR (user_id = ? and friend_id = ?)',
    current_user.id, friend_id, friend_id, current_user.id).first
end

def friendship_button(user)
    friendship = verify_friendship(user)
    if current_user != user
      if friendship.nil?

        (link_to 'Add Friend', users_path(params: { friend_id: user.id, user_id: current_user.id, confirmed: false}), method: :post, class: 'btn btn-primary')
      elsif friendship.confirmed
        content_tag(:button, 'Already friends', class: %w[btn btn-success disabled])

      elsif friendship.user_id == user.id
        (link_to 'Accept Friendship', friendship_path(friendship.id), method: :put, class: 'btn btn-warning') +
          (link_to 'Reject Friendship', friendship_path(friendship.id), method: :delete, class: 'btn btn-warning')
      else
        content_tag(:button, 'Pending Response', class: %w[btn btn-warning disabled])

     end
    end

end

def friendship_button2(user)
  friendship = verify_friendship(user)
  if current_user != user
    if friendship.nil?

      (link_to 'Add Friend', root_path(params: { friend_id: user.id, user_id: current_user.id, confirmed: false}), method: :post, class: 'btn btn-primary')
    elsif friendship.confirmed
      content_tag(:button, 'Already friends', class: %w[btn btn-success disabled])

    elsif friendship.user_id == user.id
      (link_to 'Accept Friendship', friendship_path(friendship.id), method: :put, class: 'btn btn-warning') +
        (link_to 'Reject Friendship', friendship_path(friendship.id), method: :delete, class: 'btn btn-warning')
    else
      content_tag(:button, 'Pending Response', class: %w[btn btn-warning disabled])

   end
  end

end

end