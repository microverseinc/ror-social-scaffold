def create
  @comment = Comment.new(comment_params)
  @comment.user = current_user
  @comment.post = Post.find(params[:comment][:post_id])
  if @comment.save
    redirect_to posts_path, notice: 'Comment was successfully created.'
  else
    redirect_to posts_path, alert: 'Comment was not created'
  end
end

def destroy
  comment = Comment.find(params[:id])
  comment.destroy
  redirect_to posts_path, notice: 'Comment was deleted'
end

private

def comment_params
  params.require(:comment).permit(:content)
end
