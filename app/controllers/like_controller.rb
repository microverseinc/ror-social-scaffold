class LikeController < ApplicationController
  def create
    @like = Like.new(post_id: params[:like][:post_id], user: current_user)
    if @like.save
      redirect_to posts_path, notice: 'Post was liked'
    else
      redirect_to posts_path, alert: 'Like was not registered'
    end
  end

  def destroy
    like = like.find(params[:id])
    like.destroy
    redirect_to posts_path, notice: 'unliked!'
  end

end
