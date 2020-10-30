class LikesController < ApplicationController
  def create
    if current_user.like_post(params[:post_id])
      flash[:success] = 'You liked a post.'
    else
      flash[:warning] = 'You cannot like this post.'
    end
    redirect_back
  end

  def destroy
    disliked = current_user.dislike_post(like_id: params[:id], post_id: params[:post_id])
    flash[:warning] = if disliked
                        'You disliked a post.'
                      else
                        'You cannot dislike post that you did not like before.'
                      end
    redirect_back
  end
end
