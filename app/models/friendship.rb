class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: :User
  validates :friend, uniqueness: { scope: :user }
  validates_presence_of :user_id, :friend_id

  def confirm_friend
    self.update_attributes(confirmed: true)
    Friendship.create!(friend_id: self.user_id,
                    user_id: self.friend_id,
                    confirmed: true)
  end
end
