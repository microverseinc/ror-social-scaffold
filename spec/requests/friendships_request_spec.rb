require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/friendships/create'
      expect(response).to have_http_status(:success)
    end
  end
end
