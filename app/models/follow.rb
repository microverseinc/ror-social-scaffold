class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :leader, class_name: 'User'
end
