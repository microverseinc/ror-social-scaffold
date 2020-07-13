module UserHelper
  def friendship_interaction(user)
    return nil if user == current_user

    new_friendship_path =
      friendships_path({ requester_id: current_user.id, receiver_id: user.id })

    class_html = "profile-link"

    if current_user.friends.include?(user)
      render html: link_to(
        "Unfriend",
        friendship_path_url(user),
        method: :delete, class: class_html,
      )
    elsif current_user.received_friends.include?(user)
      render html: "#{link_to(
               "Accept friend",
               friendship_path_url(user),
               method: :patch, class: class_html,
             )} #{link_to(
               "Reject friend",
               friendship_path_url(user),
               method: :delete, class: class_html,
             )}".html_safe
    elsif current_user.requested_friends.include?(user)
      render html: link_to(
        "Drop invitation",
        friendship_path_url(user),
        method: :delete, class: class_html,
      )
    else
      render html: link_to(
        "Invite friend",
        new_friendship_path,
        method: :post, class: class_html,
      )
    end
  end

  def friendship_path_url(user)
    friendship_a = Friendship.find_by_requester_id_and_receiver_id(current_user.id, user.id)

    friendship_b = Friendship.find_by_receiver_id_and_requester_id(current_user.id, user.id)

    friendship = friendship_a ? friendship_a : friendship_b
  end
end
