class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.current_user_and_friends_posts(user)
    frnds = user.friend_requests.where(confirmed: true).pluck(:friend_id)
    inverse = user.friends.where(confirmed: true).pluck(:user_id)
    frnds_and_inverse = frnds + inverse
    frnds_and_inverse << user.id
    Post.where(user_id: frnds_and_inverse).ordered_by_most_recent.includes(:user)
  end
end
