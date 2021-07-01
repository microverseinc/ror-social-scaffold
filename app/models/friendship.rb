class Friendship < ApplicationRecord
  #validates :accepted, presence: true
  validate :not_narcissist

  belongs_to :inviter, class_name: 'User', foreign_key: :user_id
  belongs_to :invitee, class_name: 'User', foreign_key: :user_id

  private

  def not_narcissist
     if invitee == inviter
      errors.add(:inviter, "can't ask theirselves for a friendship")
     end
     if invitee.nil?
      errors.add(:invitee, "can't be missing")
     end
     if inviter.nil?
      errors.add(:inviter, "can't be missing")
     end
  end
end
