class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def confirmed_friend?(user)
    sent_invitation.include?(user) && received_invitation.include?(user)
  end
end
