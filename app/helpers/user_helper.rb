module UserHelper
  def friendship_interaction(user)
    if user == current_user
      return nil
    end

    delete_path =
      friendships_path({ user_id: current_user.id, friend_id: user.id })

    edit_path =
      friendships_path({ user_id: current_user.id, friend_id: user.id, confirmed: true })

    create_path =
      Friendship.find_by_user_id_and_friend_id(current_user.id, user.id)

    class_html = "profile-link"

    if user.pending_friends.include?(current_user)
      render html: link_to(
        "Cancel Invitation",
        delete_path,
        method: :delete, class: class_html
      )

    elsif current_user.requested_friends.include?(user)
      render html: link_to(
        "Accept Invitation",
        edit_path,
        method: :patch, class: class_html, confirmed: true
      )

    else
      render html: link_to(
        "Send Invitation",
        create_path,
        method: :post, class: class_html,
      )

#     if user.pending_friendship?(current_user) && friendship.user == current_user
#       render html: link_to(
#         "Cancel friendship invitation
#         <br> user:#{friendship.user}
#         <br> friend:#{friendship.friend}
#         ",
#         unfriend_path,
#         method: :delete, class: class_html,
#       )


#     elsif user.pending_friendship?(current_user) && friendship.user != current_user
#       render html: link_to(
#         "Reject #{friendship.id}
#         user:#{friendship.user.name}
#         friend:#{friendship.friend.name}
#         ",
#         unfriend_path,
#         method: :delete, class: class_html,
#       )

    end
  end

end
