require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) do
    User.create(
      name: 'john',
      email: 'john@gmail.com',
      password: 'password'
    )
  end

  describe 'Create actions' do
    it "lets you like a post if you haven't liked it before" do
      sign_in(user, scope: :user)
      user_post = Post.create(content: 'Post to like!', user_id: user.id)
      post :create, params: { post_id: user_post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to be_present
    end

    it "doesn't let you like a post if you have liked it before" do
      sign_in(user, scope: :user)
      user_post = Post.create(content: 'Post to like!', user_id: user.id)
      post :create, params: { post_id: user_post.id }
      post :create, params: { post_id: user_post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:alert]).to be_present
    end
  end

  describe 'Destroy actions' do
    it 'lets you dislike a post if you have liked it before' do
      sign_in(user, scope: :user)
      user_post = Post.create(user_id: user.id, content: 'Post to like!')
      user_like = Like.create(user_id: user.id, post_id: user_post.id)
      delete :destroy, params: { id: user_like.id, post_id: user_post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to be_present
    end

    it "lets you not dislike a post if you currently isn't liked it" do
      sign_in(user, scope: :user)
      user_post = Post.create(user_id: user.id, content: 'Post to like!')
      user_like = Like.create(user_id: user.id, post_id: user_post.id)
      delete :destroy, params: { id: user_like.id, post_id: user_post.id }
      delete :destroy, params: { id: user_like.id, post_id: user_post.id }
      expect(response).to redirect_to(posts_path)
      expect(flash[:alert]).to be_present
    end
  end
end
