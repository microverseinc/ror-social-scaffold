class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.friendship_params
    params.permit(friend_id, user_id, status)
  end
end
