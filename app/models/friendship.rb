class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  before_update :complete_friendship

  validates :user, presence: true
  validates :friend, presence: true
  validates :user, uniqueness: { scope: [:friend] }

  private

  def complete_friendship
    Friendship.create(user_id: friend.id, friend_id: user.id) if confirmed
  end
end
