require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  describe 'Validations' do
    let(:sender) do
      User.create(name: 'sender', email: 'email@gm.com')
    end
    let(:receiver) do
      User.create(name: 'receiver', email: 'email1@gm.com')
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

    it 'should validate uniqueness of sender -> scope receiver' do
      described_class.create(sender: sender, receiver: receiver)
      expect(subject).not_to be_valid
      expect(subject.errors.full_messages).to eq ['Sender has already been taken']
    end
  end

  describe 'Associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
