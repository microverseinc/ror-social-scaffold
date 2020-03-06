require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Tests for the friendship mode', type: :model do
  let(:test_user) do
    User.new(name: 'Test User', email: 'test@user.com',
             password: 'secret', password_confirmation: 'secret')
  end
  let(:test_friend) do
    User.new(name: 'Test Friend', email: 'test@friend.com',
             password: 'secret', password_confirmation: 'secret')
  end
  let(:test_friendship) do
    Friendship.new(user_id: test_user.id, friend_id: test_friend.id,
                   confirmed: true)
  end

  def store_in_database
    test_user.save
    test_friend.save
    test_friendship.save
  end

  describe 'class method tests' do
    it 'returns the correct friendship id' do
      store_in_database
      friendship_list = Friendship.all
      expect(Friendship.get_friendship_id(friendship_list, test_user.id, test_friend.id)).to eq(test_friendship.id)
    end
  end
end
