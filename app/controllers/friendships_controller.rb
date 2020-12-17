class FriendshipsController < ApplicationController
    def create
        @friendship = Friendship.new(params[:friendship])
        if @friendship.save
          flash[:success] = "Friend request sent"
          redirect_to root_path
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        if @friendship.destroy
            flash[:success] = 'Object was successfully deleted.'
            redirect_to friendships_url
        else
            flash[:error] = 'Something went wrong'
            redirect_to friendships_url
        end
    end
    
    
end
