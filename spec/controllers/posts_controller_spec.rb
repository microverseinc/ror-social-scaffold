require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) do
    User.create(
      name: 'john',
      email: 'john@gmail.com',
      password: 'password'
    )
  end

  describe 'Controller actions' do
    it ' redirects to the sign_in if not logged in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'renders INDEX if logged in' do
      sign_in(user, scope: :user)
      get :index
      expect(response).to render_template('posts/index')
    end

    it 'redirects to the sign_in if not logged in' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'rendirect to POSTS/INDEX if logged in' do
      sign_in(user, scope: :user)
      post :create, params: { post: { content: 'This is a new post', user_id: user.id } }
      expect(response).to redirect_to(posts_path)
      expect(flash[:notice]).to be_present
    end

    it 'render INDEX if invalid content' do
      sign_in(user, scope: :user)
      post :create, params: { post: { content: '', user_id: user.id } }
      expect(response).to render_template('posts/index')
    end
  end
end
