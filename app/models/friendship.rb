class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_update :save_inverse

  private

  def save_inverse
    Friendship.create(user_id: friend.id, friend_id: user.id, confirmed: true)
  end
end
