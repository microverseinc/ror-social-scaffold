module UsersHelper
  # rubocop:disable Metrics/MethodLength
  def friendship_interaction(user)
    return nil if user == current_user

    new_friendship_path =
      friendships_path({ user_id: current_user.id, friend_id: user.id })

    class_profile = 'profile-link'
    friendship = find_friendship(user)

    if current_user.friends.include?(user)
      unfriend =
        link_to(
          'Unfriend',
          "/friendships/destroy_both/#{friendship.id}",
          method: :delete,
          class: class_profile
        )
      render html: "<br>You are now friends! #{unfriend}".html_safe
    elsif current_user.received_friends.include?(user)
      reject_friendship =
        link_to(
          'Reject Friendship',
          "/friendships/destroy_both/#{friendship.id}",
          method: :delete,
          class: class_profile
        )

      accept_friendship =
        link_to(
          'Accept Friendship',
          "/friendships/accept_both/#{friendship.id}",
          method: :patch, class: class_profile
        )

      render html: "#{accept_friendship} | #{reject_friendship} ".html_safe
    elsif current_user.requested_friends.include?(user)
      render html: link_to(
        'Drop invitation',
        "/friendships/destroy_both/#{friendship.id}",
        method: :delete,
        class: class_profile
      )
    else
      render html: link_to(
        'Invite friend',
        new_friendship_path,
        method: :post, class: class_profile
      )
    end
  end
  # rubocop:enable Metrics/MethodLength

  def find_friendship(user)
    Friendship.find_by_user_id_and_friend_id(current_user.id, user.id)
  end
end
