class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])
    redirect_to posts_path, notice: 'You liked a post.' if @like.save
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    like&.destroy
    redirect_to posts_path, notice: 'You disliked a post.'
  end
end
