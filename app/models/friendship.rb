class Friendship < ApplicationRecord
  belongs_to :requestor, class_name: 'User'
  belongs_to :requested, class_name: 'User'
end
