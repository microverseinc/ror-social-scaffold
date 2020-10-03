class Friendship < ApplicationRecord
  belongs_to :invitor, class_name: :User
  belongs_to :invitee, class_name: :User
end
