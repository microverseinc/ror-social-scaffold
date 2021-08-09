# rubocop:disable Lint/RedundantCopDisableDirective

class FriendshipsController < ApplicationController
  def new
    @friendship = Friendship.new
  end

  def create
    @friendship = Friendship.new(friendship_params)
    if request_exist?
      redirect_to users_path,
                  alert: 'Request already sent'
    elsif !request_exist? && @friendship.save
      redirect_to users_path
    end
  end

  def show; end

  def update
    @friendship = Friendship.find(params[:id])
    redirect_to users_path if (@friendship.confirmed == false) && @friendship.accept_request
  end

  def destroy
    @friendship = Friendship.where(user_id: [params[:id], current_user.id],
                                   friend_id: [current_user.id, params[:id]])
    redirect_to users_path if @friendship.destroy_all
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end

  def request_exist?
    current_user.already_friend?(User.find_by(id: params[:friendship][:friend_id]))
  end
end
# rubocop:enable Lint/RedundantCopDisableDirective
