class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.confirm_friend(user, friend)
    update(confirmed: true)
    Friendship.create!(friend_id: user,
                       user_id: friend,
                       confirmed: true)
  end
end
