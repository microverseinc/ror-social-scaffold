class Friendship < ApplicationRecord
    belongs_to :user 
    belongs_to :friend_id , class_name: 'User'
end
