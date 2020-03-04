class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.current_friendship(user_id, friend_id)
    Friendship.where("user_id = #{user_id} AND friend_id = #{friend_id}").first.id
  end
end
