require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  current_user = User.first_or_create!(username: 'username', email: 'email@example.com', password: 'password',
                                       password_confirmation: 'password')

  describe 'GET /create' do
    it 'returns http success' do
      post add_friend_path(current_user)
      expect(response).to have_http_status(302)
    end
  end
end
