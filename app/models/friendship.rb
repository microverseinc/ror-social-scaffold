class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend(friend_id, user_id)
    Friendship.create!(friend_id: friend_id,
                       user_id: user_id,
                       status: TRUE)
  end
end
