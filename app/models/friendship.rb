class Friendship < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'
  scope :comfirmed_friendships, -> { where status: true }

  def confirm_friend
    update_attributes(status: true)
    Friendship.create!(inviter_id: invitee_id,
                       invitee_id: inviter_id, status: true)
  end
end
