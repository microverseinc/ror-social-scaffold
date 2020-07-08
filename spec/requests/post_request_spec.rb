require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'should redirect to login' do
      get '/posts'
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST /posts' do
    it 'should redirect to login' do
      post '/posts'
      expect(response).to have_http_status(302)
    end
  end
end
