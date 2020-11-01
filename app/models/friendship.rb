class Friendship < ApplicationRecord
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates_uniqueness_of :friend_id, scope: :user_id

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_update :create_reverse_confirmed
  after_destroy :destroy_reverse_friendship, if: :reverse_friendship_exists?

  private

  def create_reverse_confirmed
    Friendship.create(user_id: friend_id, friend_id: user_id, confirmed: true)
  end

  def destroy_reverse_friendship
    Friendship.find_by(user_id: friend_id, friend_id: user_id, confirmed: true).destroy
  end

  def reverse_friendship_exists?
    true if Friendship.find_by(user_id: friend_id, friend_id: user_id, confirmed: true)
  end
end
