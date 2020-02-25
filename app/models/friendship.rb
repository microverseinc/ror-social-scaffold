class Friendship < ApplicationRecord
  belongs_to :sender, class_name: :User
  belongs_to :reciever, class_name: :User

  validates :sender, presence: true
  validates :reciever, presence: true
end
