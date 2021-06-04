require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create(name: 'friend', email: 'foot@bar.com', password: '123456')
  friend = User.create(name: 'friend', email: 'foot@bar.com', password: '123456')

  describe 'Associations' do
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'Helpers' do
    it '#friends return array of user friends' do
      expect(user.friends).to eq([])
    end

    it '#pending_friend returns array of pending requests' do
      expect(user.pending_friends).to eq([])
    end
  end
end
