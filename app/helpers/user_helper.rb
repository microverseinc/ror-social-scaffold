module UserHelper
  def pending_friends_list
    if @pending_friends.empty?
      notice: 'No pending friends'
    else
      content_tag :ul, class : "user-lists" do
        @pending_friends.each do |f|
          link = link_to(friend.name.to_s, user_path(friend), class: 'profile-link')
          content = content_tag(:span, link)
          concat content_tag(:li, content)
        end
      end
  end
end
  def invited_links(user)
    if current_user.friend_requests.include?(user)
      concat link_to 'Accept', confirm_request_path(user), class: 'profile-link accept'
      concat ' '
      concat link_to 'Reject', reject_request_path(user), class: 'profile-link reject'
    elsif !current_user.pending_friends.include?(user) && current_user != user && !current_user.friend?(user)
      concat link_to 'Invite to friendship', request_friendship_path(user), class: 'profile-link invite'
  end
 end
end
 