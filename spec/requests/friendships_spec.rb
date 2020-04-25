require 'rails_helper'

RSpec.describe 'Friendship', type: :request do
  describe 'User A sends a friend request to User B' do
    it 'True!' do
      get users_path
      expect(response).to have_http_status(302)
    end
  end
end