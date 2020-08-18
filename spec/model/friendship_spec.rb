require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create(name: 'joper', email: 'jsjxxs@jsjsee.com', password: 'passworddd') }
  let(:user2) { User.create(name: 'jopexxr', email: 'jsjs@jsjsee.com', password: 'passwor2ddd') }
  let(:friendship1) { user1.friendships.build(invitee_id: user2.id) }

  context 'Associations' do
    it { should belong_to(:inviter).class_name('User') }
    it { should belong_to(:invitee).class_name('User') }
  end

  context 'Validations' do
    it 'is invalid if friend does not exist' do
      friendship2 = Friendship.new(inviter_id: 100, invitee_id: user1.id)
      expect(friendship2).to_not be_valid
    end
  end
end
