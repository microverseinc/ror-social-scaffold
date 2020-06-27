module UsersHelper
  def users_list(users)
    content_tag(:ul, class: 'users-list') do
      users.each do |user|
        next unless user.id != current_user.id

        concat(
          content_tag(:li, class: 'form-index-req') do
            concat(
              render(partial: 'user_info', locals: { user: user })
            ).concat(
              if current_user.friendship_created?(user) && user.friendship_created?(current_user) &&
              !current_user.friend?(user)
                render partial: 'friend_request', locals: { user: user }
              end
            )
          end
        )
      end
    end
  end

  def user_friend_request(show_user)
    if current_user != show_user && current_user.friendship_created?(show_user) &&
       show_user.friendship_created?(current_user) && !current_user.friend?(show_user)
      render partial: 'show_friend_request', locals: { user: show_user }
    end
  end

  def user_posts(show_user)
    render partial: 'show_user_posts', locals: { user: show_user } if
    current_user.friend?(show_user) || current_user == show_user
  end
end
