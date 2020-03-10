module UsersHelper
  def friendship_status(user)
    if @logged_user.friend_request_sent?(user, @all_friendships)
      content_tag(:span, 'Friend Request Sent', class: 'friendship-status', id: "waiting-user-#{user.id}")
    elsif @logged_user.friend_request_received?(user, @all_friendships)
      correct_friendship_ids = @logged_user.friendship_ids(@all_friendships, user.id)
      accept_link = link_to('Accept',
                            controller: 'friendships', action: :update, friendships_id: correct_friendship_ids,
                            method: :put, class: 'accept-link', id: "accept-user-#{user.id}")
      decline_link = link_to 'Decline', "friendships/#{correct_friendship_ids}",
                             method: :delete, class: 'negative-link', id: "decline-user-#{user.id}"
      concat content_tag(:span, 'Friendship Invitation Received:', class: 'friendship-status')
      concat content_tag(:span, accept_link, class: 'friendship-status')
      content_tag(:span, decline_link, class: 'friendship-status')
    elsif @logged_user == user
      content_tag(:span, 'You!', class: 'friendship-status')
    elsif @logged_user.friend?(user)
      unfriend_link = link_to 'Unfriend',
                              controller: 'friendships', action: 'destroy', friendships_id: @logged_user.friendship_ids,
                              method: :delete,
                              class: 'negative-link', id: "unfriend-user-#{user.id}"
      content_tag(:span, unfriend_link, class: 'friendship-status')
    else
      add_friend_link = link_to 'Add Friend', { controller: 'friendships', action: 'create',
                                                user_id: @logged_user.id, friend_id: user.id },
                                method: :post, class: 'accept-link', id: "add-user-#{user.id}"
      content_tag(:span, add_friend_link, class: 'friendship-status')
    end
  end
end
