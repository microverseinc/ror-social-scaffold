require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    @friend = FactoryBot.create(:user, name: 'User2', email: 'user2@example.com')
    sign_in @user
  end

  describe 'Freindship features ' do
    context 'Creating a Freindship with correct params' do
      it 'Creates a freind' do
        post :create, params: { user_id: @friend.id }
        expect(response).to redirect_to(users_path)
        expect(response).to have_http_status(302)
      end
    end

    context 'Accepts a Friend Request with correct params' do
      it 'Accepts a Friend Request' do
        post :create, params: { user_id: @friend.id }
        sign_out @user
        sign_in @friend
        post :accept, params: { user_id: @user.id }
        expect(response).to redirect_to(users_path)
        expect(response).to have_http_status(302)
      end
    end
  end
end
