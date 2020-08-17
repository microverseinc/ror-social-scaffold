module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friendship_status(user)
    unless current_user == user
      if current_user.friend?(user)
        content_tag(:span, 'Friend', class: 'badge badge-success')
      elsif already_invited?(user.id)
        content_tag(:span, 'Pending', class: 'badge badge-warning')
      else
        link_to('Invite to friendship', "/users/#{user.id}/invite", class: 'badge badge-danger text-white')
      end unless current_user == user
    end
  end
end

# <% unless current_user == user %>
#   <% if current_user.friend?(user) %>
#     <span class="badge badge-success">Friend</span>
#   <% elsif already_invited?(user.id) %>
#     <span class="badge badge-warning">Pending</span>
#   <% else %>
#     <a href="/users/<%= user.id %>/invite" class="badge badge-danger text-white">Invite to friendship</a>
#   <% end %>
# <% end %>
