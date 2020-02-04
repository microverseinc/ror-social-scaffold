def create
  @comment = Comment.new(comment_params)
  @comment.user_id = current_user
  @comment.post = Post.find(params[:comment][:post_id])
  if @comment.save
    redirect_to posts_path, notice: 'Comment was successfully created.'
  else
    redirect_to posts_path, alert: 'Comment was not created'
  end
end

def destroy
  comment = Comment.find(params[:id])
  user = comment.post.user
  comment.destroy
  redirect_to user_path(user)
end

private

def comment_params
  params.require(:comment).permit(:content)
end
