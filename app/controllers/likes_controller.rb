class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.user = current_user

    if @like.save
      redirect_to posts_path, notice: 'Post was liked'
    else
      redirect_to posts_path, alert: @like.errors.full_messages.join('. ').to_s
    end
  end

  def destroy
    like = like.find_by(id: params[:id])
    like.destroy if like.user == current_user
    redirect_to posts_path
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end

end
