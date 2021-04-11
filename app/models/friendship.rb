class Friendship < ActiveRecord::Base

  after_update :add_reverse_friendship
  
  belongs_to :user, foreign_key: :friend_id, class_name: :User
  belongs_to :friend, foreign_key: :user_id, class_name: :User

  def add_reverse_friendship
    Friendship.create(requested_friend: requesting_friend, requesting_friend: requested_friend, status: true) if status
  end
end
