class Friendship < ApplicationRecord
  belongs_to :confirmer, foreign_key: :confirmer_id, class_name: 'User'
  belongs_to :requester, foreign_key: :requester_id, class_name: 'User'
end
