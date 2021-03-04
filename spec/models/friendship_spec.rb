require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'validations' do
    subject { FactoryBot.build(:friendship) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
  end

  context 'association' do
    subject { FactoryBot.build(:friendship) }
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  context 'friendship' do
    let(:sender) { FactoryBot.create(:user) }
    let(:receiver) { FactoryBot.create(:user) }

    it 'can request a frienship' do
      invitation = sender.invitations.build
      expect(invitation.user).to eq(sender)
      invitation.friend = receiver
      expect(invitation.valid?).to be_truthy
      expect(invitation.accepted?).to be_falsy
      expect(invitation.rejected?).to be_falsy
    end

    it 'can accept a frienship' do
      invitation = sender.invitations.build
      invitation.friend = receiver
      invitation.save!
      recieved_invitation = receiver.friendships.last
      recieved_invitation.accept
      expect(recieved_invitation.user).to eq(sender)
      expect(recieved_invitation.friend).to eq(receiver)
      expect(recieved_invitation.accepted?).to be_truthy
    end

    it 'can reject a frienship' do
      invitation = sender.invitations.build
      invitation.friend = receiver
      invitation.save!
      recieved_invitation = receiver.friendships.last
      recieved_invitation.reject
      expect(recieved_invitation.user).to eq(sender)
      expect(recieved_invitation.friend).to eq(receiver)
      expect(recieved_invitation.rejected?).to be_truthy
    end
  end
end
