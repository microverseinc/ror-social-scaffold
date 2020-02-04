class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 20 }

  belongs_to :user
  belongs_to :post
end
