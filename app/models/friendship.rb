class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  after_initialize :set_defaults, unless: :persisted?
  after_create :create_inverse, if: :inverse_record_nil?
  after_update :update_inverse
  after_destroy :destroy_inverse

  def set_defaults
    self.confirmed = false if self.confirmed.nil?
  end

  def create_inverse
     Friendship.create(user: friend, friend: user, confirmed: confirmed)
  end

  def inverse_record_nil?
      inverse_record.nil?
  end
  def inverse_record
    Friendship.where(user: user, friend: friend).first
  end

  def update_inverse
    ir = inverse_record
    return if ir.confirmed == confirmed
    ir.confirmed = confirmed
    ir.save
  end
end
