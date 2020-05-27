class Friendship < ApplicationRecord
  include ActiveModel::Validations
  validates :receiver_id, uniqueness: { scope: :sender_id }
  validates_with FriendshipValidation

  belongs_to :requested_friend, foreign_key: :receiver_id, class_name: :User
  belongs_to :requesting_friend, foreign_key: :sender_id, class_name: :User
end
