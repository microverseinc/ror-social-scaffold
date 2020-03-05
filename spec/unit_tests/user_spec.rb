require 'spec_helper'
require 'rails_helper'

RSpec.describe 'User model tests', type: :model do

  def store_in_database
    test_user.save
    test_user_2.save
    test_user_3.save
    test_friendship.save
    test_friendship_2.save
  end

  describe 'instance methods' do
    let(:test_user) {
      User.new(name: 'test_user', email: 'test@user.com',
                               password: 'secret', password_confirmation: 'secret') }
    let(:test_user_2) { 
      User.new(name: 'test_user_2', email: 'test2@user.com',
                                 password: 'secret', password_confirmation: 'secret') }
    let(:test_user_3) { 
      User.new(name: 'test_user_3', email: 'test3@user.com',
                                 password: 'secret', password_confirmation: 'secret') }
    let(:test_friendship) { Friendship.new(user_id: 1, friend_id: 2, confirmed: true) }
    let(:test_friendship_2) { Friendship.new(user_id: 3, friend_id: 1, confirmed: true) }
    it 'returns the correct list of friends' do
      store_in_database
      user = User.first
      user_friends = user.friends
      expect(user_friends.include?(User.second) && user_friends.include?(User.third)).to eq(true)
    end
  end
end