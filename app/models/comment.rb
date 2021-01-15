class Comment < ApplicationRecord
  validates :content,
            presence: true,
            length: { maximum: 200, too_long: '200 characters in comment is the maximum allowed.' }

  belongs_to :user, required: true
  belongs_to :post, required: true
end
