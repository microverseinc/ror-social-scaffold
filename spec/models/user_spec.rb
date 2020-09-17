require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_2) { User.create(name: 'Rebecca Y', email: 'recca@opal.com', password: 'itsG00d2Have$') }
  subject { User.create(name: 'Abd A', email: 'a.aziz@opal.com', password: 'itsB￡tt￡r2Have4llah') }

  before do
    Friendship.create(user_id: subject.id, friend_id: user_2.id)
  end

  context 'Validations' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:email) }

    it { expect(subject).to validate_length_of(:password).is_at_least(6) }
    it { expect(subject).to validate_length_of(:name).is_at_most(20) }

    it { expect(subject).to allow_value('a.aziz@opal.com').for(:email) }
    it { expect(subject).to_not allow_value('recca').for(:email) }

    it 'is expected to validate that :password cannot be empty/falsy' do
      subject.password = nil
      subject.valid?
      expect(subject.errors[:password]).to_not include('Password can\'t be blank')
    end
  end

  context 'Associations' do
    it { expect(subject).to have_many(:friendships) }
    it { expect(subject).to have_many(:posts) }
    it { expect(subject).to have_many(:comments).dependent(:destroy) }
    it { expect(subject).to have_many(:likes).dependent(:destroy) }
  end

  context 'Scope' do
    it { expect(User.users(subject.id).first.user_id).to eq(subject.id) }
    it { expect(User.users(subject.id).first.friend_id).to eq(user_2.id) }
    it { expect(User.users(subject.id).first.status).to eq('requested') }
  end
end
