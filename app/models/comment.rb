class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 200 }

  belongs_to :user, required: true
  belongs_to :post, required: true
end
