class Friendship < ApplicationRecord
  # rubocop:disable Style/HashSyntax
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  # rubocop:enable Style/HashSyntax
end
