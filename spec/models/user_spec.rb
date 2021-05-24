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
      expect(subject.friends_from_requests_sent).to be_include(friend_requested)
    end
  end

  describe 'friends should have request recieved' do
    it 'should have user sam from fixtures in friends array' do
      friend_accepted = users(:Jean)
      expect(subject.friends_from_requests_accepted).to be_include(friend_accepted)
    end
  end
end
