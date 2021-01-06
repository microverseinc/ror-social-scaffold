require 'rails_helper'

RSpec.describe Friendship do
  let(:test_user) { User.create(name: 'User', email: 'user@user.com', password: '123456') }
  let(:test_friend) { User.create(name: 'Friend', email: 'friend@friend.com', password: '123456') }
  let(:subject) do
    described_class.new(
      user_id: test_user.id,
      friend_id: test_friend.id,
      confirmed: false
    )
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    it 'is not valid without a user' do
      subject.user_id = ''
      expect(subject).not_to be_valid
    end
    it 'is not valid without a user' do
      subject.friend_id = ''
      expect(subject).not_to be_valid
    end
  end

  describe 'associations', type: :model do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:friend) }
  end
end
