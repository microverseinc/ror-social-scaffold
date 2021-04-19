class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit update destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show; end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit; end

  # POST /friendships
  # POST /friendships.json
  def check_reverse_pair(user, friend)
    Friendship.where(user_id: user, friend_id: friend)
  end

  def reverse_frienship(data)
    Friendship.create(user_id: data[:friend_id], friend_id: data[:user_id], status: data[:status])
  end

  def accept_or_reject_friend_request
    friend_status = Friendship.where(friend_id: current_user.id, user_id: params[:friend])
    friend_status.update(status: params[:status])

    if params[:status] == 'accept'
      # Friendship.create(user_id: params[:user], friend_id: params[:friend], status: params[:status])
      redirect_back(fallback_location: users_path, notice: 'Friend request Accepted')
    else
      redirect_back(fallback_location: users_path, notice: 'Friend request Rejected')
    end
  end

  # POST /friendships or /friendships.json
  def create
    @sender = current_user
    @reciever = User.find(params[:friend])

    reverse_pair = check_reverse_pair(@reciever, @sender)
    if reverse_pair.empty?
      @friend_request = @sender.friendships.build(user: @sender, friend: @reciever, status: 'Unconfirmed')

      if @friend_request.save
        redirect_to users_path, notice: 'Friend request sent successfully'
      else
        redirect_to users_path, notice: 'A pending friend request exist'
      end
    else
      redirect_to users_path, notice: 'Friendship Exists'
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        reverse_frienship(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
