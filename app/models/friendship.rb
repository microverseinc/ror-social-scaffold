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
