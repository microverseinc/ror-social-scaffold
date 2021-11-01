class Api::V1::CommentsController < ApplicationController
    def create
        @post = Post.find(params[:id])
        @comment = @post.comments.create(user: current_user, content: params[:content])

        if @comment.save
            render json: { data: @comment }, status: :ok
        end
    end
end
