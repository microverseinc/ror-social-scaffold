class Api::V1::PostsController < ApiController
  def index
    @posts = Post.all
  end
end