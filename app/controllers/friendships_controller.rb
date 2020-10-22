class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friendship = Friendship.new
  end
end
