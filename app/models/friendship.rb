class Friendship < ApplicationRecord
  # belongs_to :user
  # belongs_to :friend, class_name: "User"

  belongs_to :receiver, class_name: "User"
  belongs_to :requester, class_name: "User"

  after_create :request_friendship
  # after_destroy :destroy_friendship

  scope :not_confirmed, -> { where(confirmed: false) }

  scope :confirmed, -> { where(confirmed: true) }

  def request_friendship
    receiver.received_friendships << self
  end

  # def destroy_friendship
    # friend.friends.delete(user)
  # end
end
