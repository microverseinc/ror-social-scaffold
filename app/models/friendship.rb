class Friendship < ApplicationRecord
    belongs_to :user 
    belongs_to :fiend_id , class_name: 'User'
end
