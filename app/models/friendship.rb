class Friendship < ApplicationRecord
  # self.primary_keys = :user_id, :friend_id
  validates_uniqueness_of :user_id, scope: [:friend_id]
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  scope :they_are_friends, ->(params) { where(user_id: params[:user_id], friend_id: params[:friend_id]) }

  def self.friends(user_id, friend_id)
    @user_id = user_id
    @friend_id = friend_id
    return 'owner' if @user_id == @friend_id

    @friends = Friendship.they_are_friends(user_id: @user_id, friend_id: @friend_id).first
  end
  after_update do |friendship|
    # Code goes here
  end
end

def confirm_friend
  update_attributes(confirmed: true)
  Friendship.create!(friend_id: user_id,
                     user_id: friend_id,
                     confirmed: true)
end

def set_defaults
  self.confirmed = false if confirmed.nil?
end

def create_inverse
  Friendship.create(user: friend, friend: user, confirmed: confirmed)
end

def destroy_inverse
  ir = inverse_record
  return if ir.nil?

  ir.destroy
end

def inverse_record_nil?
  inverse_record.nil?
end

def inverse_record
  Friendship.where(user: friend, friend: user).first
end
end

