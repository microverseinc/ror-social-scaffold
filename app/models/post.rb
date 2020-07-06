class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def self.timeline_posts(current_user)
    friendz = current_user.friends
    friendz << current_user
    Post.all.where(user_id: friendz)
  end
end
