class Friendship < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  def confirm_friend
    self.update_attributes(status: true)
    Friendship.create!(inviter_id: self.invitee_id,
      invitee_id: self.inviter_id, status: true)
  end
end
