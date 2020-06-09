class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :is_friend, -> { where('acceptance =?', true) }
  scope :pendant_add, -> { where('acceptance =?', false) }
end
