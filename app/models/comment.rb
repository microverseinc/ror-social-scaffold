class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200,
                                                too_long: '200 characters in comment is the maximum allowed.' }
  validates :user_id, presence: true
  validates :post_id, presence: true

  belongs_to :user
  belongs_to :post
end
