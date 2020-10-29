class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:edit, :update]
  helper_method :friends

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendship = Friendship.create(user_id: current_user.id, friend_id: params[:id], confirmed: false)

    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Friend request sent successfully.' }
    end    
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
      else
        format.html { render :new }
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

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    current_user.friendships.find_by(friend_id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Friend request deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:status)
    end
end
