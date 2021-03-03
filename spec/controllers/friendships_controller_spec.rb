require 'rails_helper'

describe FriendshipsController do
  fixtures :friendships, :users

  setup do
    sign_in(users(:user2))
  end

  describe 'Friendship #create' do
    it 'It does not duplicate a request' do
      expect(response).to have_http_status(:ok)
      post :create, params: { friend_id: 1 }
      expect(response).to redirect_to users_url
      expect(Friendship.count).to eq 2
      expect(flash[:alert]).to be_present
      expect(flash[:alert]).to match(/Friendship is Pending*/)
    end

    it 'Sends a Friend request' do
      expect(response).to have_http_status(:ok)
      post :create, params: { friend_id: 3 }
      expect(response).to redirect_to users_url
      expect(Friendship.count).to eq 3
      expect(flash[:notice]).to match(/Sent Friend Request*/)
      expect(flash[:notice]).to be_present
    end
  end
end
