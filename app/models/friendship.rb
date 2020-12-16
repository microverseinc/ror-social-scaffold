class Friendship < ApplicationRecord
  belongs_to :requesting_user, class_name: 'User'
  belongs_to :receiving_user, class_name: 'User'
end
