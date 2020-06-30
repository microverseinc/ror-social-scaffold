class FriendshipsController < ApplicationController

	def index
		@friendships = Friendship.all
	end

	def create
		# byebug
		@friendship = Friendship.new(friendship_params)

		if @friendship.save
			redirect_to root_path, notice: "Request was successfully sent to #{@friendship.friend.name}"
		end
	end

	# def destroy
 #    @friendship = Friendship.find(params[:id])

 #    @friendship.destroy

 #    respond_to do |format|
 #      format.html { redirect_to portfolios_url, notice: 'Record was Removed'}
 #    end
 #  end


	private

	def friendship_params
		params.permit(:user_id, :friend_id)
	end
end