class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  def confirm_friend
    update_attributes(confirmed: true)
    Friendship.create!(friend_id: user_id,
                       user_id: friend_id,
                       confirmed: true)
  end

  def destroy_friendship
    if confirmed == true
      Friendship.find_by(friend_id: user_id).destroy
      destroy
    elsif confirmed == false
      destroy
    end
  end
end
