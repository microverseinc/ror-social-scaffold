class ApiController < ApplicationController
  def getposts
    @posts = Post.all
    render json: @posts
  end

  def getcomments
    @comments = Comment.find(params[:post_id])
    render json: @comments
  end
end