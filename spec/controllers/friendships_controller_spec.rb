require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it "redirects to friend's page" do
        user = build(:user)
        sign_in user
        post :create, params: { user_id: user.id, friend_id: 2 , confirmed: false }
        expect(response).to redirect_to(user_path(id: 2))
        expect(response).to have_http_status(302)
      end
    end
  end

  # describe 'PUT #update' do
  #   context 'with valid parameters' do
  #     it "redirects to friend's page" do
  #       user = build(:user)
  #       sign_in user
  #       friendship = build(:friendship)
  #       put :update, params: { id: friendship.id, confirmed: true }
  #       expect(response).to redirect_to(new_user_session_path)
  #       expect(response).to have_http_status(302)
  #     end
  #   end
  # end
end
