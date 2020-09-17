require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:inverse_friendships).class_name('Friendship') }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe "scopes" do
    let(:user1) { User.create(name: 'Marshall', email: 'uimarshall@gmail.com', password: 'pass123') }
    let(:user2) { User.create(name: 'Marshall2', email: 'uimarshall2@gmail.com', password: 'pass123') }
    let(:user3) { User.create(name: 'Marshall3', email: 'uimarshall3@gmail.com', password: 'pass123') }
   
   it 'should confirm friendship' do 
    user2.friendships.create(friend_id:user1.id)
     expect(user1.confirm_friend(user2)).to eq(true)
    end
   it 'return false when there is not friendship' do 
     expect(user1.friend?(user3)).not_to eq(true)
    end
   
   it 'It should check for pending friend request' do 
    user3.friendships.create(friend_id:user1.id)
     expect(user3.pending_friends.to_a).to eq([user1])
    end
   it 'It should check for inverse friend request' do 
    user1.friendships.create(friend_id:user3.id)
     expect(user1.friend_requests.to_a).to eq([])
    end
  end  
end
