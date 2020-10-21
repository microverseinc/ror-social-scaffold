class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User
  validates :friend, uniqueness: { scope: :user }
  validates_presence_of :user_id, :friend_id
end
