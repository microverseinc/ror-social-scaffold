class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def Friendship.get_friendship(friendship_list, user_id, friend_id)
    correct_friendship = friendship_list.find do |friendship|
      (friendship[:user_id] == user_id && friendship[:friend_id] == friend_id) ||
          (friendship[:user_id] == friend_id && friendship[:friend_id] == user_id)
    end
    correct_friendship.id
  end
end
