class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_repeated, on: [:create]
  validate :not_narcissist

  def self.safe_create(user_id, friend_id)
    transaction do
      create!(user_id: user_id,
              friend_id: friend_id, status: true)
      create!(user_id: friend_id,
              friend_id: user_id, status: false)
    end
  end

  def self.safe_delete(user_id, friend_id)
    transaction do
      find_by(user_id: user_id, friend_id: friend_id).delete
      find_by(user_id: friend_id, friend_id: user_id).delete
    end
  end

  private

  def not_repeated
    return unless Friendship.find_by(user_id: user_id, friend_id: friend_id)

    errors.add(:user_id, 'already has a pending or current friendship with the requested user')
  end

  def not_narcissist
    return unless user_id == friend_id

    errors.add(:user_id, "can't be friends to themselves")
  end
end
