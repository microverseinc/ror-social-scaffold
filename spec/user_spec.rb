require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(
      name: 'dave',
      email: 'test@test.com'
    )
  end

  describe 'Validations' do
    it 'is  invalid without valid attributes' do
      expect(subject).to_not be_valid
    end
  end
  describe 'associations' do
    it { is_expected.to have_many(:comments) }
  end
  describe 'associations' do
    it { is_expected.to have_many(:likes) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:posts) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:friends) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:pending_friends) }
  end
  describe 'associations' do
    it { is_expected.to have_many(:posts) }
  end
  describe 'associations' do
    it { is_expected.to have_many(:confirmed_friendships) }
  end
  describe 'associations' do
    it { is_expected.to have_many(:friend_requests) }
  end
end
