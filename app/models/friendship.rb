class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # validates_presence_of :user_id
  # validates_presence_of :friend_id
  validates_presence_of :confirmed

  def accepted
    update(confirmed: true)
  end
end
