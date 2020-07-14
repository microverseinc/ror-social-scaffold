module UserHelper
  def friendship_interaction(user)
    return nil if user == current_user

    new_friendship_path =
      friendships_path({ requester_id: current_user.id, receiver_id: user.id })
    class_html = 'profile-link'

    if current_user.friends.include?(user)
      render html: link_to(
        'Unfriend',
        find_friendship(user),
        method: :delete, class: class_html
      )
    elsif current_user.received_friends.include?(user)
      id = find_friendship(user, true)

      reject_friendship =
        link_to(
          'Reject Friendship',
          find_friendship(user),
          method: :delete, class: class_html
        )

      accept_friendship =
        link_to(
          'Accept Friendship',
          friendship_path({ id: id, confirmed: true }),
          method: :patch, class: class_html
        )

      render html: "#{accept_friendship} | #{reject_friendship} ".html_safe
    elsif current_user.requested_friends.include?(user)
      render html: link_to(
        'Drop invitation',
        find_friendship(user),
        method: :delete, class: class_html
      )
    else
      render html: link_to(
        'Invite friend',
        new_friendship_path,
        method: :post, class: class_html
      )
    end
  end

  def find_friendship(user, return_id = false)
    friendship_a =
      Friendship.find_by_requester_id_and_receiver_id(current_user.id, user.id)
    friendship_b =
      Friendship.find_by_receiver_id_and_requester_id(current_user.id, user.id)

    friendship = friendship_a || friendship_b
    return_id ? friendship.id : friendship
  end
end
