require 'rails_helper'

RSpec.describe User, type: :model do
  include Warden::Test::Helpers
  Warden.test_mode!

  let(:current_user) { User.create!(name: 'Tester', email: 'test@example.com', password: 'f4k3p455w0rd') }
  let(:user) { User.create(name: 'JohnDoe', email: 'johndoe@example.com', password: '123456') }
  let(:user2) { User.create(name: 'Ying Yang', email: 'yingyang@example.com', password: '123456') }

  describe 'validations' do
    describe 'name' do
      it 'must be present' do
        user = described_class.new(name: 'John', email: 'john@example.com', password: '123456')
        expect(user).to be_valid
        user.name = nil
        expect(user).to_not be_valid
      end
    end

    describe 'email' do
      it 'must be present' do
        user = described_class.new(name: 'John', email: 'john@example.com', password: '123456')
        expect(user).to be_valid
        user.email = nil
        expect(user).to_not be_valid
      end
    end

    describe 'password' do
      it 'must be present' do
        user = described_class.new(name: 'John', email: 'john@example.com', password: '123456')
        expect(user).to be_valid
        user.password = nil
        expect(user).to_not be_valid
      end
    end
  end

  describe 'associations' do
    it 'has many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many sent friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eq(:has_many)
    end

    it 'has many received friendships' do
      user = User.reflect_on_association(:inverse_friendships)
      expect(user.macro).to eq(:has_many)
    end
  end

  describe '#pending_friends' do
    it 'returns an array' do
      login_as(current_user, scope: :user)

      pending_requests = current_user.pending_friends
      expect(pending_requests).to be_an Array
    end

    # it 'should return an array with status false for all containing object' do
    #   login_as(current_user, scope: :user)
    #   current_user.friendships.build(friend_id: user.id, confirmed: false).save

    #   pending_requests = current_user.pending_friends
    #   request_statuses = pending_requests.map do |user|
    #     user.inverse_friendships.where(user_id: current_user.id).pending_requests.first.confirmed
    #   end.compact
    #   expect(request_statuses.all?(false)).to be true
    # end
  end

  describe '#friends' do
    it 'returns an array' do
      login_as(current_user, scope: :user)

      requests = current_user.friends
      expect(requests).to be_an Array
    end

    it 'should return an array with status true for all containing object' do
      login_as(current_user, scope: :user)
      current_user.friendships.build(friend_id: user, confirmed: true).save
      user.friendships.build(friend_id: current_user, confirmed: true).save

      requests = current_user.friends
      request_statuses = requests.map do |user|
        user.friendships.where(friend_id: current_user.id).accepted_requests.first.status
      end.compact
      expect(request_statuses.all?(true)).to be true
    end
  end

  describe '#friend_requests' do
    it 'returns an array' do
      login_as(current_user, scope: :user)

      requests = current_user.friend_requests
      expect(requests).to be_an Array
    end

    it 'should return an array with status false for all containing object' do
      login_as(current_user, scope: :user)
      user.friendships.build(friend_id: current_user, confirmed: false).save
      user2.friendships.build(friend_id: current_user, confirmed: false).save

      requests = current_user.friend_requests
      request_statuses = requests.map do |user|
        user.friendships.where(friend_id: current_user).pending_requests.first.confirmed
      end.compact
      expect(request_statuses.all?(false)).to be true
    end
  end

  describe '#confirm_friend' do
    it 'should change friend request status to true' do
      login_as(current_user, scope: :user)
      user.friendships.build(friend_id: current_user.id, confirmed: false).save

      current_user.confirm_friend(user)
      expect(current_user.friends[0]).to eq user
      expect(user.friends[0]).to eq current_user
    end
  end

  describe '#decline_friendship' do
    it 'should change friend request status to true' do
      login_as(current_user, scope: :user)
      user.friendships.build(friend_id: current_user.id, confirmed: false).save

      current_user.decline_friendship(user.id)
      expect(current_user.friends[0]).to be nil
    end
  end
end