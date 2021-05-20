class Friendship < ApplicationRecord
  scope :confirmed, -> { where('confirmed = true') }
  scope :unconfirmed, -> { where('confirmed = false') }

  belongs_to :user
  belongs_to :friend, class_name: :User
end
