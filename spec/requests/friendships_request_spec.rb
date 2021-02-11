require 'rails_helper'

RSpec.describe 'Friendships', type: :request do
  describe '#create' do
    it 'should create the friend request' do
      user = create(:user)
      another_user = create(:user)
      sign_in(user)
      post user_friendships_path(another_user), params: nil

      expect(another_user.addressees.count).to eq(1)
    end
  end

  describe '#update' do
    it 'should accept the friend request' do
      user = create(:user)
      another_user = create(:user)
      another_user.send_friend_request_to(user)
      sign_in(user)
      patch user_friendships_path(another_user), params: nil

      expect(user.friend?(another_user)).to be_truthy
    end
  end

  describe '#destroy' do
    it 'should delete the friend request' do
      user = create(:user)
      another_user = create(:user)
      user.send_friend_request_to(another_user)
      another_user.accept_friend_request_of(user)
      sign_in(user)
      delete user_friendships_path(another_user)

      expect(user.requests.count).to be_zero
    end
  end
end
