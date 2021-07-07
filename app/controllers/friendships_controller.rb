class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    
    new_friend = current_user.friendships.build(friend_id: friend.id, status: "pending")
    puts "---------"
    puts new_friend.valid?
    if new_friend.save
      render body: "Saved"
    else
      render body: "Not saved"
    end
  end

  def update
    friend = User.find(params[:friend_id])
    
    new_friend = current_user.friendships.build(friend_id: friend.id, status: "approved")
    puts "---------"
    puts new_friend.valid?
    if new_friend.save
      render body: "Saved"
    else
      render body: "Not saved"
    end
  end
end
