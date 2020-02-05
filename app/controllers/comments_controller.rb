class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to posts_path, notice: 'Comment was successfully created.'
    else
      redirect_to posts_path, alert: "#{@comment.errors.full_messages.join('. ')}"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end