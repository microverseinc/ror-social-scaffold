class Friendship < ApplicationRecord
  after_initialize :default_status

  validates :status, :user_id, :friend_id, presence: true

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def accept
    self.status = 1
    save!
  end

  def accepted?
    status == 1
  end

  def reject
    self.status = -1
    save!
  end

  def rejected?
    status == -1
  end

  private

  def default_status
    self.status ||= 0
  end
end
