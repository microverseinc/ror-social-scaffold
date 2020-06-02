require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe 'Freindship features ' do
    context 'Creating a Freind with correct params' do
      it 'Creates a freind' do
        post :create, params: { user_id: @user.id, @friend_id:  }
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You liked a post./)
      end
    end

    context 'Accepts a Friend Request with correct params' do
      it 'Accepts a Friend Request' do
        post :accept, params: { post_id: @post.id }
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You liked a post./)
      end
    end

    context 'removing a freind with valid params' do
      it 'removes a freind' do
        post :create, params: { post_id: @post.id }
        expect(flash[:notice]).to match(/You liked a post./)
        delete :destroy, params: { id: Like.all[0].id, post_id: @post.id, user_id: @user.id }
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to match(/You disliked a post./)
      end
    end
  end
end
