class Friendship < ApplicationRecord
  # rubocop:disable Style/HashSyntax
  validates :user_id, uniqueness: { scope: :friend_id }
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  # rubocop:enable Style/HashSyntax
end
