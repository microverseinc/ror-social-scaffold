class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept_request
    Friendship.create(friend_id: user_id, user_id: friend_id, confirmed: true)
    update(confirmed: true)
  end
end
