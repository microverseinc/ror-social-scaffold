class Friendship < ApplicationRecord
  belongs_to :requested_friend, foreign_key: :receiver_id, class_name: :User
end
