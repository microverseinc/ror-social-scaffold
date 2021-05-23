class Friendship < ApplicationRecord
  after_update(:add_reverse_friendship_pair)
  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  def add_reverse_friendship_pair
    friendship = Friendship.find(id)
    return unless friendship&.accepted

    Friendship.create(inviter_id: friendship.invitee_id, invitee_id: friendship.inviter_id,
                      accepted: true)
  end
end
