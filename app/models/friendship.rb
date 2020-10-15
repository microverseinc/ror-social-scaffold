class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  
  scope :accepted, -> { where('confirmed =?', true) }
  scope :pending, -> { where('confirmed =?', false) }
end
