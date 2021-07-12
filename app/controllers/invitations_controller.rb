class InvitationsController < ApplicationController
  def create
    invitation = Invitation.new(user_id:params[:user], friend_id:params[:friend], confirmed: false )
    if invitation.save
      redirect_to current_user
    else
      render 
    end
  end
end

