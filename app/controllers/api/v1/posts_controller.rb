class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all
    render json: { data: posts }, status: :ok
  end

  def show
    post = Post.find(params[:id])
    render json: { data: post.comments.all }, status: :ok
  end
end
