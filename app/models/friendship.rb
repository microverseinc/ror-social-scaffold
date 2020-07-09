class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :request_friendship
  after_create :pend_friendship
  scope :accepted_friendships, -> { where(confirmed: true) }
  # after_destroy :destroy_friendship

  def request_friendship
    friend.requested_friends << user unless friend.requested_friends.include?(user)
  end

  def pend_friendship
    user.pending_friends << friend unless user.pending_friends.include?(friend)
  end
end
