module UserHelper
  def friend_or_delete(user, current_user)
    if current_user.friendships.find_by(friend_id: user.id)
      link_to current_user.friendships.find_by(friend_id: user.id), method: :delete, data: { confirm: 'Are you sure you want to delete this friendship request?' }, class: 'but' do
        'Delete friendship request'
      end

    else
      form_for current_user.friendships.build(friend: user) do
        hidden_field :user_id

        hidden_field :friend_id
        submit 'Invite to friendship'
      end
    end
  end
end
