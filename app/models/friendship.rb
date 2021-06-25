class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, uniqueness: { scope: :friend_id }
end


# reciprocal = inverse
# i.e The reciprocal of 5/8 is 8/5.

#method to create two way friendship and update both user's friend list.

def self.create_reciprocal_for_ids(user_id, friend_id)
  
      user_friendship = Friendship.create(user_id: user_id, friend_id: friend_id)
      friend_friendship = Friendship.create(user_id: friend_id, friend_id: user_id)

      [user_friendship, friend_friendship]
end

#method to destroy two way friendship and update both user's friend list.


def self.destroy_reciprocal_for_ids(user_id, friend_id)

      friendship1 = Friendship.find_by(user_id: user_id, friend_id: friend_id)
      friendship2 = Friendship.find_by(user_id: friend_id, friend_id: user_id)

      friendship1.destroy
      friendship2.destroy
end