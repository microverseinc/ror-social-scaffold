class FriendshipsController < ApplicationController
    def create
      @friendship = Friendship.new(friendship_params)
      @friendship.status = FALSE
  
      if @friendship.save
        redirect_to users_path, notice: 'You requested to be friends!'
      else
        redirect_to users_path, alert: 'You cannot add this user.'
      end
    end

    def accept(user)
        friendship = Friendship.find_by(user_id = current_user.id, friend_id = user.id)
        if friendship
          friendship.status = TRUE
        else
          friendship = Friendship.find_by(user_id = user.id, friend_id = current_user.id)
          if friendship
            friendship.status = TRUE
          end
        end
    end
  
    def destroy(user)
      friendship = Friendship.find_by(user_id = current_user.id, friend_id = user.id)
      if friendship
        friendship.destroy
        redirect_to users_path, notice: 'You removed a friend!'
      else
        friendship = Friendship.find_by(user_id = user.id, friend_id = current_user.id)
        if friendship
          friendship.destroy
          redirect_to users_path, notice: 'You removed a friend!'
        else 
          redirect_to posts_path, alert: 'You cannot remove this friend!'
        end
      end
    end

    private

    def friendship_params
        params.permit(:user_id, :friend_id)
    end
  end