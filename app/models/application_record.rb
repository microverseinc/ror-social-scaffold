class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :approved, -> { where('status = ?', true) }
end
