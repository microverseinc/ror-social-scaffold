class Friendship < ApplicationRecord
  belongs_to :sent_friendship, class_name: 'User'
  belongs_to :received_friendship, class_name: 'User'
  scope :confirmed, -> { where("status = true") }
end
