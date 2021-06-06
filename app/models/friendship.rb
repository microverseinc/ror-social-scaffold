class Friendship < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  after_update :create_inverse, if: :inverse_record_nil?
  after_destroy :destroy_inverse

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def set_defaults
    self.status = false if status.nil?
  end

  def create_inverse
    Friendship.create(user: friend, friend: user, status: status)
  end

  def update_inverse
    inv_rec = inverse_record
    return if inv_rec.status == status

    inv_rec.status = status
    inv_rec.save
  end

  def destroy_inverse
    inv_rec = inverse_record
    return if inv_rec.nil?

    inv_rec.destroy
  end

  def inverse_record_nil?
    inverse_record.nil?
  end

  def inverse_record
    Friendship.where(user: friend, friend: user).first
  end
end
