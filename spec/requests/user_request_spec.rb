require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'should redirect to login' do
      get '/users'
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /users/sign_up' do
    it 'should render signup form successfully' do
      get '/users/sign_up'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /users/sign_in' do
    it 'should render login form successfully' do
      get '/users/sign_in'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /users' do
    it 'should create a new user' do
      post '/users'
      expect(response).to have_http_status(:success)
    end
  end
end
