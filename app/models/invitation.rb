class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: 'user'
  belongs_to :invitee, class_name: 'user'

validates: status, inclusion: { in: %w[pending accepted] }
end
