class Friendship < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
end
