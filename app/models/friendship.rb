class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  before_save :friendship_exist?

  private

  def friendship_exist?
    raise ActiveRecord::Rollback if Friendship.where(user_id: user_id, friend_id: friend_id).exists? ||
                                    Friendship.where(user_id: friend_id, friend_id: user_id).exists?
  end
end
