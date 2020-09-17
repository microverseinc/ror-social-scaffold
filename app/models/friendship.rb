# rubocop: disable Layout/LineLength
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :find_friendship,
        ->(user1, user2) { where("(user_id = #{user1.id} AND friend_id = #{user2.id}) OR (user_id = #{user2.id} AND friend_id = #{user1.id})") }
end
# rubocop: enable Layout/LineLength
