require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end

  context 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:posts) }
    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships).dependent(:destroy) }
  end

  context 'method validation' do
    let(:paul) { User.create(name: 'Paul', email: 'paul@gmail.com', password: 'furious') }
    let(:ryan) { User.create(name: 'Ryan', email: 'ryan@gmail.com', password: 'luxurious') }
    let(:lisa) { User.create(name: 'Lisa', email: 'lisa@gmail.com', password: 'lisarocks') }
    let(:check) { Friendship.create(user_id: paul.id, friend_id: ryan.id, status: true) }

    it 'return true if they are mutual friends' do
      check
      expect(paul.check_friendship?(ryan)).to be(true)
    end
    it 'return false if they are not mutual friends' do
      check
      expect(paul.check_friendship?(lisa)).to be(false)
    end
  end
end
