require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  test 'friendship should be valid' do
    user1 = User.create(email: '1@11.ru', name: 'Beka1', gravatar_url: 'https://hwisis.jdlsl.re', password: '1234567')
    user2 = User.create(email: '1@121.ru', name: 'Beka1', gravatar_url: 'https://hwisis.jdlsl.re', password: '1234567')

    @friendship = Friendship.new(user_id: user1.id, friend_id: user2.id)
    assert @friendship.valid?
  end

  test 'friendship should_not be valid' do
    @friendship = Friendship.new(user_id: 1, friend_id: 2)
    assert_not @friendship.valid?
  end
end
