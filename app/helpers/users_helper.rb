module UsersHelper

  def users_list(users)
    content_tag(:ul, :class => 'users-list') do
      users.each do |user|
        if user.id != current_user.id
          concat(
            content_tag(:li, :class => 'form-index-req' ) do
              concat(
                render partial: 'user_info', locals: { user: user }).concat(
                if user.friendship_created?(current_user)
                  render partial: 'friend_request', locals: { user: user }
                end
              )
            end
          )
        end
      end
    end
  end

end
