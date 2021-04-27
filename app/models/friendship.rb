class Friendship < ApplicationRecord
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  belongs_to :user
  scope :friends, -> { where('status = ?', true) }
  scope :not_friends, -> { where('status = ?', false) }
end
