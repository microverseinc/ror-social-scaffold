require 'rails_helper'

RSpec.describe 'FriendsRequests', type: :request do
  let(:user) { User.create(name: 'User1', email: 'user1@email.com', password: 'password') }

  describe "GET '/user/:id/friends'" do
    it 'loads sign in when not logged in' do
      get user_friendships_path(user)
      expect(response).to redirect_to('/users/sign_in')
    end
    it 'load friends after log in' do
      sign_in user
      get user_friendships_path(user)
      expect(response).to render_template(:index)
    end
  end
end
