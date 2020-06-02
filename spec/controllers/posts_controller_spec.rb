require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'GET #index of post' do
    it 'gets all the user posts and render index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe 'Post #create of post' do
    context 'with valid params' do
      it 'creates a new post' do
        post :create, params: { post: { content: 'sjdjsbdjdjkkksnkcj' } }
        # expect(response).to be_successful
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
      end
    end
    context 'with invalid params' do
      it 'renders new template' do
        post :create, params: { post: { content: '' } }
        expect(response).to render_template(:index)
      end
    end
  end
end
