require 'rails_helper'

RSpec.describe 'FriendshipInvitations', type: :request do
  describe 'GET /create' do
    it 'returns http success' do
      get '/friendship_invitations/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/friendship_invitations/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
