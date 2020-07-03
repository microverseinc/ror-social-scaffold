require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  before(:each) do
    @user = User.create(name: 'Test', email: 'test@xyz.com',
                        password: '123456')
    @user1 = User.create(name: 'Test1', email: 'test1@xyz.com',
                         password: '123456')
    sign_in @user
    request.env['HTTP_REFERER'] = '/users'
    Friendship.create!(user_id: @user.id, friend_id: @user1.id, confirmed: true)
    Friendship.create!(user_id: @user1.id, friend_id: @user.id, confirmed: true)
  end

  describe '#create friendship' do
    context 'with valid params' do
      it 'creates a new friendship' do
        post :create, params: { user_id: @user.id, friend_id: @user1.id }
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/Request was successfully sent to #{@user1.name}/)
      end
    end
  end

  describe '#destroy friendship' do
    context 'with valid params' do
      it 'destroys a friendship' do
        delete :destroy, params: { id: @user1.id }
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/You have unfriended #{@user1.name}/)
      end
    end
  end

  describe '#reject' do
    context 'with valid params' do
      it 'rejects a friendship request' do
        logout @user
        sign_in @user1
        post :create, params: { user_id: @user1.id, friend_id: @user.id }
        post :reject, params: { friendship_id: @user1.id }
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to match(/You have rejected #{@user1.name} request/)
      end
    end
  end

  describe '#confirm' do
    context 'with valid params' do
      it 'confirms a friendship request' do
        logout @user1
        sign_in @user
        post :create, params: { user_id: @user1.id, friend_id: @user.id }
        post :confirm, params: { friendship_id: @user1.id }
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You have accepted #{@user1.name} request/)
      end
    end
  end
end
