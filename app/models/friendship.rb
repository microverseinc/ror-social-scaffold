class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  before_save :check_same_user

  private

  def check_same_user
    raise ActiveRecord::Rollback if Friendship.where(user_id: user_id, friend_id: friend_id).exists?
  end
end
