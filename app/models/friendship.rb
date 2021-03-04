class Friendship < ApplicationRecord
  validates_presence_of :status, :user_id, :friend_id
end
