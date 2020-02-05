class LikeController < ApplicationController
  def create
    @like = Post.find(params[:post_id]).likes.new(user: current_user)

    if @like.save
      redirect_to posts_path, notice: 'Post was liked'
    else
      redirect_to posts_path, alert: 'Like was not registered'
    end
  end

  def destroy
    like = like.find(params[:id])
    like.destroy if like.user == current_user
    redirect_to posts_path
  end

end
