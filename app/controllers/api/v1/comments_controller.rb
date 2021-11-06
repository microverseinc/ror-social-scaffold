class Api::V1::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @comment = @post.comments.create(user: current_user, content: params[:content])

    render json: { data: @comment }, status: :ok if @comment.save
  end
end
