class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User



  def mirror?(friendship)
    true if user.id == friendship.friend.id && friend.id == friendship.user.id
    false
  end

end

