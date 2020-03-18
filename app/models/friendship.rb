class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept
    update_attribute(:confirmed, true)
  end
end
