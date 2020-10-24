class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      flash[:success] = 'Comment was successfully created.'
    else
      flash[:danger] = @comment.errors.full_messages.join('. ').to_s
    end
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
