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
end
