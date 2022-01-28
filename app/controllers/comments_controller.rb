class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user

    if @comment.save
      redirect_to posts_path, notice: 'Comment was successfully created.'
    else
      redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  def take_comments
    @comments = Post.find(params[:post_id]).comments
    render json: @comments
  end

  def post_comment
    @comment = Comment.new(comment_params)
    render json: @comment

    if @comment.save
      render json: @comment
    else
      puts 'not save'
      # redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
