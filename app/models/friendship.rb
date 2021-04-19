class Friendship < ActiveRecord::Base
  include ActiveModel::Validations

  after_update :add_reverse_friendship

  validates :friend_id, uniqueness: { scope: :user_id }
  validates :friend_id, presence: true
  validates :user_id, presence: true
  # validates_with FriendshipValidation

  belongs_to :requested_friend, foreign_key: :friend_id, class_name: :User
  belongs_to :requesting_friend, foreign_key: :user_id, class_name: :User

  def add_reverse_friendship
    return unless confirmed

    Friendship.create(requested_friend: requesting_friend, requesting_friend: requested_friend,
                      confirmed: true)
  end
end
