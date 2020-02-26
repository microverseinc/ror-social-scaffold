# require 'spec_helper'
require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Validation tests' do
    subject { Friendship.new }
    let(:sender) { User.create(name: 'Audrey', email: 'audrey@gmail.com') }
    let(:reciever) { User.create(name: 'Maru', email: 'maru@gmail.com') }

    it 'valid with sender and reciever' do
      subject.sender = sender
      subject.reciever = reciever
      expect(subject).to be_valid
    end

    it 'not valid without a reciever' do
      subject.sender = sender
      expect(subject).to_not be_valid
    end

    it 'not valid without a sender' do
      subject.reciever = reciever
      expect(subject).to_not be_valid
    end

    it 'adds a new Friendship' do
      count = Friendship.count
      subject.update!(sender: sender, reciever: reciever, status: true)
      expect(Friendship.count).to eq(count + 1)
    end
  end

  context 'Associations tests' do
    let(:sender) { User.create(name: 'Audrey', email: 'audrey@gmail.com') }
    let(:reciever) { User.create(name: 'Maru', email: 'maru@gmail.com') }
    let(:friendship) { sender.friendships.build(reciever_id: reciever.id) }
    let(:inverse_friendship) { reciever.inverse_friendships.build(sender_id: sender.id) }

    it 'has many friendships' do
      expect(sender.respond_to?(:friendships)).to be_truthy
      expect(sender.friendships).to include(friendship)
    end

    it 'has many inverse friendships' do
      expect(reciever.respond_to?(:inverse_friendships)).to be_truthy
      expect(reciever.inverse_friendships).to include(inverse_friendship)
    end
  end
end
