# rubocop: disable Layout/LineLength
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :friendship_exists,
        ->(user, friend) { where(" (user_id = #{user.id} AND friend_id = #{friend.id})") }

  scope :inverse_friendships,
        ->(user, friend) { where("( user_id = #{user.id} AND friend_id = #{friend.id}) OR ( user_id = #{friend.id} AND friend_id = #{user.id})") }

  before_create :check_friendship

  def check_friendship
    if Friendship.friendship_exists(User.find(user_id), User.find(friend_id)).to_a.any?
      error[:friendship] << 'Frinndship already exists'
    end
    true
  end
end
# rubocop: enable Layout/LineLength
