class Friendship < ApplicationRecord
  belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id'
  belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id'
  scope :friends, -> { where('confirmed =?', true) }
  scope :not_friends, -> { where('confirmed =?', false) }
end
