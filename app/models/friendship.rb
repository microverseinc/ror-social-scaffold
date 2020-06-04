class Friendship < ApplicationRecord
  validates :user_id, uniqueness: { scope: :friend_id }
  validate :check_duplicate
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  private

  def check_duplicate
    friendships = Friendship.all
    return unless friendships.any? { |f| f.user_id == friend_id && f.friend_id == user_id }

    errors.add(:user_id, 'Friendship between these users already exist')
  end
end
