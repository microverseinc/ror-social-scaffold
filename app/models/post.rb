class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def timeline_posts(user)
    us = user.friends.map(&:id)
    us << user.id
    us = us.join(',')
    first_part = 'SELECT * FROM posts WHERE user_id IN'
    Post.find_by_sql("#{first_part} (SELECT id FROM users WHERE id IN(#{us})) ORDER BY created_at")
  end
end
