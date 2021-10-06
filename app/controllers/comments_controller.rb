class CommentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @comments = Post.find(params[:post_id]).comments
    respond_to do |format|
      format.html { @comments }
      format.xml { render xml: @comments }
      format.json { render json: @comments }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.json { render json: @comment, status: :created }
        format.html { redirect_to posts_path, notice: 'Comment was successfully created.' }
      end
    else
      redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
