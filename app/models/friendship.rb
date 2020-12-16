class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User
  validates :friend, uniqueness: { scope: :user }
  validate :prevent_self_association

  after_create :reciprocate_friendship

  scope :requested, -> { where(status: 'requested') }
  scope :received, -> { where(status: 'received') }
  scope :confirmed, -> { where(status: 'confirmed') }

  private

  def reciprocate_friendship
    new_friendship = Friendship.new({ user: friend, friend: user, status: 'received' })
    new_friendship.save unless Friendship.where({ user: friend, friend: user }).exists?
  end

  def prevent_self_association
    errors.add(:base, 'User and friend can not be the same') if friend == user
  end
end
