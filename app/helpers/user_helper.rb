module UserHelper
  def friendship_interaction(user)
    return nil if user == current_user

    friend_path =
      friendships_path({ user_id: current_user.id, friend_id: user.id })
    unfriend_path =
      Friendship.find_by_user_id_and_friend_id(current_user.id, user.id)
    class_html = 'profile-link'

    if user.friendable?(current_user)
      render html: link_to(
        'Add Friend',
        friend_path,
        method: :post, class: class_html
      )
    elsif user.unfriendable?(current_user)
      render html: link_to(
        'Unfriend',
        unfriend_path,
        method: :delete, class: class_html
      )
    end
  end
end
