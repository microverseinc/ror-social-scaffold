class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end
end
