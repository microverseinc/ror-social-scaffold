require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Users connections' do
    before(:all) do
      @jhon = User.create(name: 'jhon', email: 'jhon@mail.com', password: '1234567')
      @ana = User.create(name: 'ana', email: 'ana@mail.com', password: '1234567')
    end

    it 'index' do
      sign_in @jhon
      get :index
      expect(response).to have_http_status(200)
    end

    it 'show' do
      sign_in @jhon
      post :show, params: { id: @ana.id }
      expect(response).to have_http_status(200)
    end

    it 'add_and_accept_friends' do
      sign_in @jhon
      get :add_friend, params: { id: @ana.id }
      sign_out @jhon
      sign_in @ana
      get :accepts_friend, params: { id: @jhon.id }
      expect(response).to have_http_status(302)
    end

    it 'add_and_reject_friendship' do
      sign_in @jhon
      get :add_friend, params: { id: @ana.id }
      sign_out @jhon
      sign_in @ana
      ids = Friendship.last.id
      get :accepts_friend, params: { id: ids }
      expect(response).to have_http_status(302)
    end
  end
end
