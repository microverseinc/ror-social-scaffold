class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @friendships = current_user.inverted_friendships
  end

  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_to users_path, notice: 'Friendship request sent!'
    else
      flash[:notice] = 'Something went wrong!'
      render :users
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship2 = inverse_params(@friendship)

    @friendship.confirmed = true

    if @friendship.save && @friendship2.save
      redirect_to friendships_path, notice: 'Friendship request accepted!'
    else
      flash[:notice] = 'Something went wrong, please try again!'
      render 'friendships#index'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    redirect_to friendships_path, notice: 'Request rejected!'
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end

  def inverse_params(first)
    second = Friendship.new(user_id: first.friend_id, friend_id: first.user_id, confirmed: true)
    second
  end
end
