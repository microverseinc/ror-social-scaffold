class Friendship < ApplicationRecord
  belongs_to :sender, foreign_key: :friendable_id, class_name: 'User'
  belongs_to :reciver, foreign_key: :friend_id, class_name: 'User'
end
