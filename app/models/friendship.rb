class Friendship < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  def self.request(user, friend)
    return if user == friend

    transaction do
      create(user: user, friend: friend, status: 'pending')
      create(user: friend, friend: user, status: 'requested')
    end
  end

  def self.accept(user, friend)
    transaction do
      updated_at = Time.now
      accept_one_side(user, friend, updated_at)
      accept_one_side(friend, user, updated_at)
    end
  end

  def self.accept_one_side(user, friend, updated_at)
    request = find_by(user_id: user.id, friend_id: friend.id)
    request.status = 'accepted'
    request.updated_at = updated_at
    request.save!
  end
end
