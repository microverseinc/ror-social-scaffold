class Friendship < ApplicationRecord
    belongs_to :request_sender, class_name: 'User'
    belongs_to :request_receiver, class_name: 'User'
end
