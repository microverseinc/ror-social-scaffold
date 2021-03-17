class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def request(user, friend)
    unless user == friend or Friendship.exists?(user, friend) 
      transaction do
        create(user: 'user', friend: 'friend', status: 'pending')
        create(user: 'friend', friend: 'user', status: 'requested')
      end
    end
  end
end
