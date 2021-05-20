class Friendship < ApplicationRecord
  belong_to :users
  belong_to :friend, class_name: :User
end
