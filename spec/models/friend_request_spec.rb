require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Validations' do
    let(:sender) do
      User.create(name: 'sender')
    end
    let(:receiver) do
      User.create(name: 'receiver')
    end

    subject do
      described_class.new(sender: sender, receiver: receiver)
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a sender' do
      subject.sender = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a receiver' do
      subject.receiver = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
