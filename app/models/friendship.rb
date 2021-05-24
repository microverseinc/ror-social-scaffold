class Friendship < ApplicationRecord
  scope :confirmed, -> { where('confirmed = true') }
  scope :unconfirmed, -> { where('confirmed = false') }
  validates :user_id, presence: true
  validates :friend_id, presence: true

  belongs_to :user
  belongs_to :friend, class_name: :User
end
