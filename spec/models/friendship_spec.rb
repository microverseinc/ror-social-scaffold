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

  context 'friendship creation' do
    let(:sender) { FactoryBot.create(:user) }
    let(:receiver) { FactoryBot.create(:user) }

    it 'can send a frienship' do
      invitation = sender.invitations.build
      expect(invitation.user).to eq(sender)
    end
  end
end
