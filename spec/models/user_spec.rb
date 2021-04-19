require 'rails_helper'

RSpec.describe User, type: :model do
  # Model Tests
  context 'with correct params' do
    before do
      @user = User.create(name: 'Peter Parker', email: 'peter.parker@email.com', password: 'abc123', gravatar_url: '')
    end

    it 'creates a user' do
      expect(@user).to be_valid
    end

    it 'reads a user' do
      expect(User.find_by(name: 'Peter Parker')).to eq(@user)
    end
  end

  context 'with incorrect params' do
    before do
      @user = User.create(email: 'peter.parker@email.com', password: 'abc123', gravatar_url: '')
    end

    it 'cannot create a user' do
      expect(@user).not_to be_valid
    end

    it 'cannot read a user' do
      expect(User.find_by(name: 'Peter Parker')).not_to eq(@user)
    end
  end

  # Association Tests
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }

  context 'user as an inviter' do
    before do
      User.create(name: 'Peter Parker', email: 'peter.parker@email.com', password: 'abc123', gravatar_url: '')
      User.create(name: 'Jane Watson', email: 'jane_watson@email.com', password: 'abc123', gravatar_url: '')
    end

    let(:inviter) { User.find_by_name('Peter Parker') }
    let(:invitee) { User.find_by_name('Jane Watson') }
    let(:friend_request) { inviter.friendships.build(invitee_id: invitee.id) }

    it { should have_many(:friendships) }
    it { should have_many(:invitees) }

    it 'can invite another user to be a friend' do
      expect(friend_request).to be_valid
    end

    it 'can check the status of a friend request' do
      friend_request
      friendship_status = inviter.friendships.first.status
      expect(friendship_status).to eq(false)
    end

    it 'can see the name of the invitee' do
      invitee_user = User.find(friend_request.invitee_id)
      invitee_user_name = User.find(invitee_user.id).name
      expect(invitee_user_name).to eq('Jane Watson')
    end
  end

  context 'user as an invitee' do
    before do
      User.create(name: 'Peter Parker', email: 'peter.parker@email.com', password: 'abc123', gravatar_url: '')
      User.create(name: 'Jane Watson', email: 'jane_watson@email.com', password: 'abc123', gravatar_url: '')
    end

    let(:inviter) { User.find_by_name('Peter Parker') }
    let(:invitee) { User.find_by_name('Jane Watson') }
    let(:friend_request) { inviter.friendships.create(invitee_id: invitee.id, status: true) }

    it { should have_many(:inverse_friendships) }
    it { should have_many(:inviters) }

    it 'can check the status of a friend request' do
      friend_request
      friendship_status = invitee.inverse_friendships.first.status
      expect(friendship_status).to eq(true)
    end

    it 'can see the name of the inviter' do
      inviter_user = User.find(friend_request.inviter_id)
      inviter_user_name = User.find(inviter_user.id).name
      expect(inviter_user_name).to eq('Peter Parker')
    end
  end

  # Validation Tests
  it 'is not valid without valid attributes' do
    expect(User.new).to_not be_valid
  end

  context 'it is valid with valid attributes' do
    describe '#name' do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name) }
    end
  end
end
