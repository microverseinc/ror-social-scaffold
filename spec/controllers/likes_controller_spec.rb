require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
    @post = @user.posts.create!(content: 'sjdjsbdjdjkkksnkcj')
  end

  describe 'Liking and disliking a post ' do
    context 'liking with valid params' do
      it 'likes a post' do
        post :create, params: { post_id: @post.id }
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You liked a post./)
      end
    end

    context 'liking a non-existant post' do
      it 'outputs a flash indicating you cannot like this post' do
        post :create, params: { post_id: 10 }
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/You cannot like this post./)
      end
    end

    context 'disliking with valid params' do
      it 'dislikes a post' do
        post :create, params: { post_id: @post.id }
        expect(flash[:notice]).to match(/You liked a post./)
        delete :destroy, params: { id: Like.all[0].id, post_id: @post.id, user_id: @user.id }
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You disliked a post./)
      end
    end
  end
end
