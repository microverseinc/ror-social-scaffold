module Api
  module V1
    class CommentsController < ApiController

      def create
        @comment = Comment.new(id: params[:post_id], content: params[:content], user: current_user)
        # @comment.post_id = params[:post_id]
        @comment.user = current_user

        if @comment.save
          @comment
        else
          'egrqegr'
        end
      end

    end
  end
end