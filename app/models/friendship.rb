class Friendship < ApplicationRecord
  belongs_to :user, class_name: 'user', foreign_key: "user_id"
  belongs_to :friend, class_name: 'user', foreign_key: "friend_id"
end
