class Friendship < ApplicationRecord
  belongs_to :receiver, class_name: 'User'
  belongs_to :requester, class_name: 'User'

  scope :not_confirmed, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }
end
