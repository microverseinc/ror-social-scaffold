class Friendship < ApplicationRecord
  enum status: { pending: 0, confirmed: 1 }
  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
