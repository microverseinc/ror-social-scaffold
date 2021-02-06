class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :foreign_key => :friend_id, class_name: 'User'

  validates :user_id, presence: true
  validates :friend_id, presence: true  

  # validates :users_friendships, presence: false

  # def users_friendships
  #   if User.where(user_id: friend_id, friend_id: user_id).exist? || User.where(user_id: user_id, friend_id: friend_id).exist?
  #     self.errors.add(:user_id, 'Already friends!')
  #   end
  # end
  
end
