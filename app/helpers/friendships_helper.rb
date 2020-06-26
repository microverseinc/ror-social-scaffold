module FriendshipsHelper
  def friendship_params
    params.permit(:confirmer_id, :requester_id)
  end

  def pending_friendships(friendship)
    content_tag(:ul) do
      friendship.each do |x|
        concat(content_tag(:li, x.requester.name).concat(render(partial: 'confirm_decline'))) if x.confirmed == false
      end
    end
  end
end
