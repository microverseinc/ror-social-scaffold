class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, foreign_key: :user_id, class_name: :User
  self.primary_key = :user_id
end
