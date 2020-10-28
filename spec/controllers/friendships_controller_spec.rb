require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  describe 'POST #create' do
    it 'creates a new friendship entry to database' do
      user1 = create(:user)
      user2 = create(:user)
      sign_in user1

      expect do
        post :create, params: { user_id: user1.id,
                                friend_id: user2.id, confirmed: false }
      end .to change { Friendship.count }.from(0).to(1)
      expect(response).to redirect_to(user_path(id: user2))
      expect(response).to have_http_status(302)
    end
  end

  describe 'PUT #update' do
    it 'confirms a friendship' do
      user1 = create(:user)
      sign_in user1

      friendship = create(:friendship)
      put :update, params: { id: friendship.id, confirmed: true }
      expect(response).to redirect_to(friendships_path)
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes a friendship entry from database' do
      user1 = create(:user)
      sign_in user1

      friendship = create(:friendship)
      expect { delete :destroy, params: { id: friendship.id } }.to change { Friendship.count }.from(1).to(0)
      expect(response).to redirect_to(friendships_path)
      expect(response).to have_http_status(302)
    end
  end
end
