require './app/models/user.rb'

RSpec.describe User, type: :model do
  let(:user) { User.new(id: 1) }
  let(:friend) { User.new(id: 2) }
  let(:friendship) { Friendship.new(id: 1, user_id: 1, friend_id: 2, confirmed: false) }

  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).class_name('Friendship') }
  end

  describe 'methods' do
    context 'friends' do
      it 'should return an array' do
        expect(user.friends).to be_an(Array)
      end
    end
    context 'pending_friends' do
      it 'should return an array' do
        expect(user.pending_friends).to be_an(Array)
      end
    end
    context 'friend_requests' do
      it 'should return an array' do
        expect(user.friend_requests).to be_an(Array)
      end
    end
    context 'friend?' do
      it 'should return a boolean' do
        expect(user.friend?(user)).to be_kind_of(FalseClass || TrueClass)
      end
    end
  end
end