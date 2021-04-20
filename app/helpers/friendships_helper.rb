module FriendshipsHelper
  def check_friendship(friend_id)
    Friendship.where('(user_id=? and friend_id=?) or (user_id=? and friend_id=?)', current_user.id, friend_id, friend_id, current_user.id).first
  end

  def friendship_link(user)
    friendship = check_friendship(user)
    if friendship.nil?
      link_to('| Add Friend',
              friendships_path(params: { friendship: { friend_id: user.id, user_id: current_user.id } }), method: :post, class: 'profile-link')
    elsif friendship.confirmed?
    elsif friendship.user_id == user.id
      link_to('| Accept', friendship_path(friendship.id), method: :put, class: 'profile-link') +
      link_to('| Reject', friendship_path(friendship.id), method: :delete, class: 'profile-link')
    else
      content_tag(:p, 'Pending response')
    end

  end
end

# <%# friendship_status = Friendship.where(user: current_user.id, friend: user.id).first %>
#     <%# if friendship_status %>
#       <%#= "| #{ friendship_status.status }" %>
#     <%# else %>
#       <%#= link_to '| Add Friend',  add_friend_user_path(user), class: 'profile-link' unless current_user == user %>
#     <% end %>
#       <%= current_user.friendships.find_by(friend: user.id).status unless current_user == user %>
