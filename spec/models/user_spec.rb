require 'rails_helper'

RSpec.describe User do
  fixtures :users
  fixtures :friendships

  subject(:user) { users(:John) }
  let(:invalid_user) { User.new }

  describe 'Validity with name,password and email from fixtures' do
    it 'should be valid from fixtures' do
      expect(user).to be_valid
    end
  end

  describe :invalid_name do
    it 'should have valid name' do
      user = User.new(name: '', email: 'some@gmail.com')
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
      expect(user).not_to be_valid
    end
  end

  describe :invalid_password do
    it 'should have valid name' do
      user = User.new(name: 'samrood', email: 'some@gmail.com')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
      expect(user).not_to be_valid
    end
  end

  describe :invalidity do
    it 'should not be valid with blank fields' do
      expect(invalid_user).not_to be_valid
    end
  end

  describe 'friends list has all friends' do
    it 'should have two friends from fixtures' do
      expect(subject.friends.count).to eq 2
    end
  end

  describe 'friends should have request sent' do
    it 'should have user sam from fixtures in friends array' do
      friend_requested = users(:Sam)
      expect(subject.friends_from_requests_sent).to include(friend_requested)
    end
  end

  describe 'friends should have request recieved' do
    it 'should have user sam from fixtures in friends array' do
      friend_accepted = users(:Jean)
      expect(subject.friends_from_requests_accepted).to be_include(friend_accepted)
    end
  end
end
