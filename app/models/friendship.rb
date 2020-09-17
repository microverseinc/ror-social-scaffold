class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :requester_id, presence: true

  scope :find_friendship,
        ->(user, friend) { where("(user_id = #{user.id} AND friend_id = #{friend.id})") }
  scope :find_both_friendships,
        ->(user, friend) { where("(user_id = #{user.id} AND friend_id = #{friend.id}) OR (user_id = #{friend.id} AND friend_id = #{user.id})") } # rubocop: disable Layout/LineLength

  before_create :save_friendship
  after_create :duplicate_friendship

  private

  def duplicate_friendship
    Friendship.find_or_create_by(user_id: friend_id, friend_id: user_id, requester_id: user_id)
  end

  def save_friendship
    if Friendship.find_friendship(User.find(user_id), User.find(friend_id)).to_a.any?
      errors[:friendship] << 'Friendship already exists'
      throw :abort
    end
    true
  end
end
