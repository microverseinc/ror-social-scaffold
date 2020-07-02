require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@xyz.com',
                        password: '123456')
    sign_in @user
  end

  describe 'GET #index' do
    it 'gets all the users and render index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'Renders user show page' do
      get :show, params: { id: @user.id }
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end

    context 'If user does not exis' do
      it 'is not a success' do
        begin
          get :show, params: { id: -1 }
        rescue StandardError
          ActiveRecord::RecordNotFound
        end
        expect(response).not_to render_template(:show)
      end
    end
  end

  describe 'GET #pending_friends' do
    it 'gets all the users pending friends' do
      get(:pending_friends, params: { user_id: @user.id })
      expect(response).to be_successful
      expect(response).to render_template(:pending_friends)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #friend_requests' do
    it 'gets all the users friend requests' do
      get(:friend_requests, params: { user_id: @user.id })
      expect(response).to be_successful
      expect(response).to render_template(:friend_requests)
      expect(response).to have_http_status(200)
    end
  end
end
