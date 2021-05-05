require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get '/posts'
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET posts#create' do
    it 'should get create' do
      post '/posts'
      expect(response).to have_http_status(302)
    end
  end
end
