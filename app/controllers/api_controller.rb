class ApiController < ApplicationController
  def getposts
    @posts = Post.all
    render json: @posts
  end

  def getcomments
    @posts = Post.all
    render json: @posts
  end
end