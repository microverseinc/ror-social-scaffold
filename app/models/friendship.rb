class Friendship < ApplicationRecord
  # validates :accepted, presence: true
  validate :not_narcissist
  validate :not_inviting_twice, on: :create

  belongs_to :inviter, class_name: 'User'
  belongs_to :invitee, class_name: 'User'

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: false) }

  private

  def not_narcissist
    errors.add(:inviter, "can't ask themselves for friendship") if invitee == inviter
    errors.add(:invitee, "can't be missing") if invitee.nil?
    errors.add(:inviter, "can't be missing") if inviter.nil?
  end

  def not_inviting_twice
    return unless inviter.friends_unfiltered.include?(invitee)

    errors.add(:inviter, "can't invite. There's a previous request created")
  end
end
