class Friendship < ApplicationRecord
  enum status: %i[pending accepted]
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
