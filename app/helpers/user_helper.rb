module UserHelper
  def new_friendship(user)
    unless user.id == current_user.id
      link = if current_user.confirmed_friendships.where(friend_id: user.id).first
               content_tag(:small, 'Befriended already!', class: 'p-1 rounded btn-success')
             elsif current_user.pending_friendships.where(friend_id: user.id).first
               content_tag(:small, 'Request sent!', class: 'p-1 rounded btn-warning')
             else
               capture do
                 link_to 'Add friend',
                         friendships_path(
                           friendship: {
                             user_id: current_user,
                             friend_id: user,
                             confirmed: false
                           }
                         ),
                         method: 'post',
                         class: 'p-1 rounded btn-dark small no-link'
               end
             end
    end
    link
  end
end
