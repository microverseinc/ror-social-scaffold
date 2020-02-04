class Post < ApplicationRecord
  validates :content, presence: true

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
end
