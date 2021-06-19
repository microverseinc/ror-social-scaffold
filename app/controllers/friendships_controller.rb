class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[index show]

  
  def index
    @friendships = Friendship.all
  end

  
  def show; end

  def new
    @friendship = Friendship.new
  end

  
  def edit; end

  
  def create
    friend = User.find(params[:friend_id])
    if Friendship.where(user_id: current_user.id, friend_id: friend.id).exists?
      redirect_to root_path, notice: 'Frend request already sent'
      return
    elsif current_user == friend
      redirect_to root_path, notice: "You can't send request to yourself"
      return
    end

    @friendship = current_user.friendships.build(friend_id: friend.id)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to users_path, notice: 'Friend request sent' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to root_path, notice: 'Friend request accepted.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Friendship was declined' }
      format.json { head :no_content }
    end
  end

  private

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
