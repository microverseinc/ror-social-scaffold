class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirm_friend
    update_attributes(confirmed: true)
  end
end
