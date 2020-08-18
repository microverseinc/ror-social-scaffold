require 'rails_helper'

RSpec.describe User, type: :model do
  let(:inviter) { User.new(email: 'smith@hello.org', name: 'Smith', password: '12343455fv') }
  let(:invitee) { User.new(email: 'paul@yah.com', name: 'Paul', password: '12323fdsdf') }

  context 'Associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:friendships).with_foreign_key('inviter_id') }
    it { should have_many(:invitations).with_foreign_key('invitee_id').class_name('Friendship') }
  end

  context 'Validations' do
    it 'is valid with valid attributes' do
      inviter.email = 'coal@jj.com'
      expect(inviter).to be_valid
    end

    it 'is not valid without a name' do
      invitee.name = nil
      expect(invitee).to_not be_valid
    end

    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:name) }
  end
end
