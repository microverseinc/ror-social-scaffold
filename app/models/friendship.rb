class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :invitee, class_name: 'User'
end
