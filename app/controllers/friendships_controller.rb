class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.html do
          redirect_to root_path, notice: 'Friend request sent!'
        end
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      if @friendship.update(confirmed: true)
        format.html do
          redirect_to root_path, notice: 'You are now friends!'
        end
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
