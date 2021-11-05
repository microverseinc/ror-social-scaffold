class CommentsController < ApplicationController
  def index
    render json: [*Comment.where(post_id: params[:post_id])]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'Comment was successfully created.' }
        format.json { render json: { message: 'Comment Created!' } }
      end
    else
      respond_to do |format|
        format.html { redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s }
        format.json { render json: { message: 'Error!' } }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
