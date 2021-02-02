module UserHelper
  def pending_friends_list
    if @pending_friends.empty?
      content_tag :p, 'No pending friends.'
    else
      content_tag :ul, class: 'users-list' do
        @pending_friends.each do |friend|
          link = link_to(friend.name.to_s, user_path(friend), class: 'profile-link')
          content = content_tag(:span, link)
          concat content_tag(:li, content)
        end
      end
    end
  end

  def invite_links(user)
    if current_user.friend_requests.include?(user)
      concat link_to 'Accept', confirm_request_path(user), class: 'profile-link accept link'
      concat ' '
      concat link_to 'Reject', reject_request_path(user), class: 'profile-link reject link'
    elsif !current_user.pending_friends.include?(user) && current_user != user && !current_user.friend?(user)
      concat link_to 'Request Friendship', request_friendship_path(user), class: 'profile-link invite link'
    end
  end
end
