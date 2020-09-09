require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Validations' do
    let(:friend) do
      User.create(name: 'friend', email: 'email@gm.com')
    end
    let(:inverse_friend) do
      User.create(name: '', email: 'email1@gm.com')
    end

    subject do
      described_class.new(friend: friend, inverse_friend: inverse_friend)
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a friend' do
      subject.friend = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an inverse_friend' do
      subject.inverse_friend = nil
      expect(subject).to_not be_valid
    end

    it 'should validate uniqueness of friend -> scope inverse_friend' do
      described_class.create(friend: friend, inverse_friend: inverse_friend)
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to eq ['Friend has already been taken']
    end
  end

  describe 'Associations' do
    it { should belong_to(:friend) }
    it { should belong_to(:inverse_friend) }
  end
end
