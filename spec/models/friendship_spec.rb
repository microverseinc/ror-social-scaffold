require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user = User.create!(name: 'Diego de Araujo Lira', email: 'diego@lira.com', password: '123123')
    @friend = User.create!(name: 'Laura Saldanha Guimaraes Lira', email: 'laura@saldanha.com', password: '123123')
    @friendship_request_true = Friendship.create!(user_id: @user.id, friend_id: @friend.id, status: false);
  end

  context 'check for friendship actions' do
    it 'should create a friendship request' do
      expect(@friendship_request_true).to eql(Friendship.first)
    end

    it 'should fail when creating a friendship request to a friend that does not exists' do
      expect(Friendship.create(user_id: @user.id, friend_id: 1000000, status: false)).not_to be_valid
    end
  end
end
