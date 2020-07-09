class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_destroy :destroy_friendship

  scope :not_confirmed, -> { where(confirmed: false) }

  scope :confirmed, -> { where(confirmed: true) }

  def destroy_friendship
    friend.friends.delete(user)
  end
end
