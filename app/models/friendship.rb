class SelfFriendshipValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "You can't be your own friend" if record.requester_id == record.confirmer_id
  end
end

class Friendship < ApplicationRecord
  belongs_to :confirmer, foreign_key: :confirmer_id, class_name: 'User'
  belongs_to :requester, foreign_key: :requester_id, class_name: 'User'

  validates :confirmer, uniqueness: { scope: :requester, message: 'Friend Request Already Sent' }
  validates_with SelfFriendshipValidator

  after_update :inverse_friend

  def inverse_friend
    Friendship.create(
      confirmer_id: requester.id,
      requester_id: confirmer.id,
      confirmed: true
    )
  end
end
