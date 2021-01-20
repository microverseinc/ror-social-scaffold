class Friendship < ApplicationRecord
  enum status: [:pending, :accepted]
  belongs_to :user
  belongs_to :friend, class_name: 'User'

end
