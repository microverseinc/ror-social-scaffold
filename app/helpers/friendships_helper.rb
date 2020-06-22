module FriendshipsHelper
  def friendship_params
    requester_id = current_user.id
    params.permit(:confirmer_id, :requester_id => requester_id)
  end
end
