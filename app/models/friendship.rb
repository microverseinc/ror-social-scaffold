class Friendship < ApplicationRecord
  include ActiveModel::Validations

  after_update :add_reverse_friendship

  validates :receiver_id, uniqueness: { scope: :sender_id }
  validates :receiver_id, presence: true
  validates :sender_id, presence: true
  validates_with FriendshipValidation

  belongs_to :requested_friend, foreign_key: :receiver_id, class_name: :User
  belongs_to :requesting_friend, foreign_key: :sender_id, class_name: :User

  def add_reverse_friendship
    Friendship.create(requested_friend: requesting_friend, requesting_friend: requested_friend, status: true) if status
  end
end
