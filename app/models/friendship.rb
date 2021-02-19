class Friendship < ApplicationRecord
  belongs_to :received_friendship
  belongs_to :sent_friendship
end
