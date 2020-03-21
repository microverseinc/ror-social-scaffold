require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  describe 'friendship' do
    before(:all) do
      @ivan = create(:user)
      @remy = create(:user)
    end

    it 'request' do
      sign_in @ivan
      post :create, params: { friend_id: @remy.id }
      expect(response).to have_http_status(302)
    end

    it 'cancel' do
      sign_in @ivan
      post :create, params: { friend_id: @remy.id }
      post :cancel_friend_request, params: { id: @remy.id }
      expect(response).to have_http_status(302)
    end

    it 'accept' do
      sign_in @ivan
      post :create, params: { friend_id: @remy.id }
      sign_out @ivan
      sign_in @remy
      post :accept_friend_request, params: { id: @ivan.id }
      expect(response).to have_http_status(302)
    end

    it 'reject' do
      sign_in @ivan
      post :create, params: { friend_id: @remy.id }
      sign_out @ivan
      sign_in @remy
      delete :reject, params: { id: @ivan.id }
      expect(response).to have_http_status(302)
    end

    it 'unfriend' do
      sign_in @ivan
      post :create, params: { friend_id: @remy.id }
      sign_out @ivan
      sign_in @remy
      post :accept_friend_request, params: { id: @ivan.id }
      delete :destroy, params: { id: @ivan.id }
      expect(response).to have_http_status(302)
    end
  end
end
