class InvitationsController < ApplicationController
  def create  
invitation = current_user.invitation.new(inviter_id: params[:inviter],
  invitee_id: params[:invitee],
  status: 'pending')

if request.save
redirect_to(User.find(params[:invitee]))
else
render(users_path)
end
end
  end
end


