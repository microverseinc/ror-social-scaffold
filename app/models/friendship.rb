class DuplicateValidator < ActiveModel::Validator
  def validate(record)
    friend1 = Friendship.find_by(user_id: record.user_id, friend_id: record.friend_id)
    friend2 = Friendship.find_by(user_id: record.friend_id, friend_id: record.user_id)
    record.errors[:base] << 'This relationship already exists' unless friend1.nil? && friend2.nil?
  end
end

class SelfFriendshipValidator < ActiveModel::Validator
  def validate(record)
    record.errors[:base] << "You can't be your own friend" if record.user_id == record.friend_id
  end
end

class Friendship < ApplicationRecord
  validates_with DuplicateValidator, on: :create
  validates_with SelfFriendshipValidator

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user, presence: true
  validates :friend, presence: true
end
