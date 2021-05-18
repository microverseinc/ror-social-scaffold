class FriendshipsController < ApplicationController
  def create
    @current_user = current_user
    @friendship = @current_user.senders.new()
    @friendship.receiver_id = params[:receiver_id]

    if @comment.save
      redirect_to posts_path, notice: 'Request was successfully sent.'
    else
      redirect_to posts_path, alert: @comment.errors.full_messages.join('. ').to_s
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:receiver_id)
  end
end