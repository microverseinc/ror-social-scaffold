module FriendshipHelper
  def friendship_button(user, current_user)
    form_for current_user.friendships.build(friend: user.user, confirmed: true) do |f|
      f.hidden_field :user_id
      f.hidden_field :friend_id
      f.hidden_field :confirmed
      f.submit 'Accept Friendship'
    end
  end
end
