require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@xyz.com',
                        password: '123456')
    sign_in @user
    @post = @user.posts.create!(content: 'sjdjsbdjdjkkksnkcj')
    request.env['HTTP_REFERER'] = '/posts'
  end

  describe 'Post #create of comments' do
    context 'with valid params' do
      it 'creates a new post' do
        post :create, params: { post_id: @post.id, user_id: @user.id, comment: { content: 'abcd' } }
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/Comment was successfully created./)
      end
    end

    context 'with invalid params' do
      it 'renders current template' do
        post :create, params: { post_id: @post.id, user_id: @user.id, comment: { content: '' } }
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/Content can't be blank/)
      end
    end
  end
end
