class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(post_id: params[:post_id])

    if @like.save
      flash[:success] = 'You liked a post.'
      redirect_to posts_path
    else
      flash[:warning] = 'You cannot like this post.'
      redirect_to posts_path
    end
  end

  def destroy
    like = Like.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
    if like
      like.destroy
      flash[:warning] = 'You disliked a post.'
      redirect_to posts_path
    else
      flash[:warning] = 'You cannot dislike post that you did not like before.'
      redirect_to posts_path
    end
  end
end
