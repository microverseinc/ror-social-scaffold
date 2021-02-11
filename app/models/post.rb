class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :by_me, ->(user) { where(user_id: user.id) }
  scope :by_my_friends, ->(user) { where(user_id: user.friend_lists.pluck(:id)) }
  scope :by_known_people, ->(user) { by_me(user).or(by_my_friends(user)) }

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
