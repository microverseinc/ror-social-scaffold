module FriendshipsHelper
  def confirm_decline(request)
    render partial: 'confirm_decline', locals: { request: request } if request.sender.confirm_inverse?(current_user)
  end
end
