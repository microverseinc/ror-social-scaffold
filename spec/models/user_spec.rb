require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.create!(email: 'dbcoacnosa@example.com', password: '123456', name: 'Example2')
  User.create!(email: 'asicasxsa@example.com', password: '123456', name: 'Example1')

  describe 'validations' do
    it 'should validate presence of content' do
      expect(user.valid?).to be true
    end

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships) }
    it { should have_many(:posts) }
    it { should have_many(:inverted_friendships) }
    it { should have_many(:friend_requests) }
    it { should have_many(:pending_friendships) }
    it { should have_many(:pending_friends) }
  end

  describe '#friends' do
    it 'should return array of friends' do
      expect(user.friends).to be_an_instance_of(Array)
    end
  end
end
