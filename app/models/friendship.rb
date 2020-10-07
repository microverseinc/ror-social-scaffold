class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  scope :friend_list, -> { where(confirmed: true) }
  scope :friend_requests, -> { where(confirmed: nil) }
end
