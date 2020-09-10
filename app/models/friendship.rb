class Friendship < ApplicationRecord
  attribute :status, :string, default: 'requested'
  belongs_to :user
end
