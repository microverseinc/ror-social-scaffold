# class DuplicateValidator < ActiveModel::Validator
# def validate(record)
# friend1 = Friendship.find_by(requester_id: record.requester_id, confirmer_id: record.confirmer_id)
# friend2 = Friendship.find_by(requester_id: record.confirmer_id, confirmer_id: record.requester_id)
# record.errors[:base] << 'This relationship already exists' unless friend1.nil? && friend2.nil?
# end
# end

class SelfFriendshipValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "You can't be your own friend" if record.requester_id == record.confirmer_id
  end
end

class Friendship < ApplicationRecord
  belongs_to :confirmer, foreign_key: :confirmer_id, class_name: 'User'
  belongs_to :requester, foreign_key: :requester_id, class_name: 'User'

  validates :confirmer, uniqueness: { scope: :requester, message: 'Friend Request Already Sent' }
  # validates_with DuplicateValidator, on: :create
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
