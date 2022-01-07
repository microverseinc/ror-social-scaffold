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

  def comments_index
    post_id = params[:post_id]
    comments = Post.find_by(id: post_id).comments
    render json: comments.to_json
  end

  def create_comment
    comment = Comment.create(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end

  end

  # def create_comment
  #   p '/////////////////////////////////////////////////////////////////////////'
  #   puts comment_params
  #   @comment = Comment.create(comment_params)
  #   render json: @comment
  #   if @comment.save
  #     render json: @comment
  #   # redirect_to posts_path, notice: 'Comment was successfully created.'
  #   else
  #     puts 'not saving'
  #     # redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s
  #   end
  # end

  private

  def comment_params
    params.permit(:user_id, :post_id, :content)
  end
end
