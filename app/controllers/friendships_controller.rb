class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = current_user.friendships
    @friendships_count = @friend
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
  def create
    @friendship = current_user.friendships.build(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to request.referrer, notice: 'Friendship requested!' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { redirect_to request.referrer, alert: 'Error'}
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def decline_friendship
    @friendship = Friendship.decline_friendship(params[:friendship])
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Friendship request declined!'}
      format.json { render :show, status: :created, location: @friendship }
    end
  end

  def accept_friendship
    Friendship.accept_friendship(params[:friendship])
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Friendship accepted!'}
      format.json { render :show, status: :created, location: @friendship }
    end
  end

  def undo_friendship
    Friendship.undo_friendship(params[:friendship])
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Friendship undone!'}
      format.json { render :show, status: :created, location: @friendship }
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
