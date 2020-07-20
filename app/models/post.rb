class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.current_user_and_friends_posts(user)
    frnds = user.friend_requests.where(confirmed: true).pluck(:friend_id)
    inverse = user.friends.where(confirmed: true).pluck(:user_id)
    frnds_and_inverse = frnds + inverse
    frnds_and_inverse << user.id
    Post.where(user_id: frnds_and_inverse).order(created_at: :desc).includes(:user)
  end
end
