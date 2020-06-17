class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend,class_name: "User"
  validates :friend_id,:user_id,uniqueness: true
end
