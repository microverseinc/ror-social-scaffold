class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :author, class_name: 'User'

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  # scope :allowed_posts, -> { where(current_user.friends?(friend)) } 
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  # has_one author
end
