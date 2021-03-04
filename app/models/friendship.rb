class Friendship < ApplicationRecord
  ACCEPT = 1
  REJECT = -1
  PENDING = 0

  after_initialize :default_status

  validates :status, :user_id, :friend_id, presence: true

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :all_friends_of, ->(u) { where('(user_id=? OR friend_id=?) AND status=?', u.id, u.id, Friendship::ACCEPT) }
  scope :check_friends, ->(r) { where('user_id=? OR friend_id=?', r.id, r.id) }

  def accept
    self.status = Friendship::ACCEPT
    save!
  end

  def accepted?
    status == Friendship::ACCEPT
  end

  def reject
    self.status = Friendship::REJECT
    save!
  end

  def rejected?
    status == Friendship::REJECT
  end

  private

  def default_status
    self.status ||= Friendship::PENDING
  end
end
