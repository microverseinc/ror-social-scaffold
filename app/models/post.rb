class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 20 }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
