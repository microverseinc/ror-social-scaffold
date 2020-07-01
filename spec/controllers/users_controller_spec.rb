require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Users connections' do
    before(:all) do
      @jhon = User.create(name: 'jhon', email: 'jhon@mail.com', password: '1234567')
      @ana = User.create(name: 'ana', email: 'ana@mail.com', password: '1234567')
    end

    it 'request' do
      sign_in @jhon
      post :create, params: { friend_id: @ana.id }
      expect(response).to have_http_status(302)
    end

    it 'cancel' do
      sign_in @jhon
      post :create, params: { friend_id: @ana.id }
      post :cancel_friend_request, params: { id: @ana.id }
      expect(response).to have_http_status(302)
    end

    it 'accept' do
      sign_in @jhon
      post :add_friend, params: { friend_id: @ana.id }
      sign_out @jhon
      sign_in @ana
      post :accepts_friend, params: { id: @jhon.id }
      expect(response).to have_http_status(302)
    end

    it 'reject' do
      sign_in @jhon
      post :create, params: { friend_id: @ana.id }
      sign_out @jhon
      sign_in @ana
      delete :reject, params: { id: @jhon.id }
      expect(response).to have_http_status(302)
    end

    it 'unfriend' do
      sign_in @jhon
      post :create, params: { friend_id: @ana.id }
      sign_out @jhon
      sign_in @ana
      post :accept_friend_request, params: { id: @jhon.id }
      delete :destroy, params: { id: @jhon.id }
      expect(response).to have_http_status(302)
    end
  end
end