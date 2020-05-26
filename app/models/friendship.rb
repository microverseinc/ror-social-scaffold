class Friendship < ApplicationRecord
  belongs_to :requested_friend, foreign_key: :receiver_id, class_name: :User
  belongs_to :requesting_friend, foreign_key: :sender_id, class_name: :User
end
