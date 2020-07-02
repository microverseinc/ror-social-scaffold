require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@xyz.com',
                        password: '123456')
    @post = Post.create!(user_id: @user.id, content: 'asiudgiadi')
    sign_in @user
    request.env['HTTP_REFERER'] = '/posts'
  end

  describe '#create like' do
    context 'with valid params' do
      it 'creates a new like' do
        post :create, params: { post_id: @post.id }
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You liked a post./)
      end
    end

    context 'with invalid params' do
      it 'gives an error' do
        post :create, params: { post_id: 3 }
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/You cannot like this post./)
      end
    end
  end

  describe '#destroy like' do
    context 'with valid params' do
      it 'destroy a like' do
        @like = Like.create!(post_id: @post.id, user_id: @user.id)
        post :destroy, params: { id: @like.id, post_id: @post.id, user_id: @user_id }
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You disliked a post./)
      end
    end

    context 'with invalid params' do
      it 'should give an error' do
        @like = Like.create!(post_id: @post.id, user_id: @user.id)
        post :destroy, params: { id: 5, post_id: 5, user_id: 5 }
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/You cannot dislike post that you did not like before./)
      end
    end
  end
end
