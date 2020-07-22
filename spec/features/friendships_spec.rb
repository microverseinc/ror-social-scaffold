require 'rails_helper'

RSpec.feature 'Friendship' do
  let!(:user) { create(:random_user) }
  let!(:friend) { create(:random_friend) }

  context 'friendship does not exist' do
    it 'should create only one instance when request friendship' do
      login_user(user)
      visit_and_click(friend, 'Request Friendship')
      expect(Friendship.all.count).to eql(1)
    end

    it 'should create a second instance when friend accepts friendship' do
      create(:unconfirmed_friendship)
      login_user(friend)
      visit_and_click(user, 'Accept friendship')
      expect(Friendship.all.count).to eql(2)
    end
  end

  context 'User adds a friend and' do
    it 'the request is sent successfully' do
      login_user(user)
      visit_and_click(friend, 'Request Friendship')
      expect(page).to have_content('You sent a friend request!')
    end

    it 'friend request is accepted' do
      create(:unconfirmed_friendship)
      login_user(friend)
      visit_and_click(user, 'Accept friendship')
      expect(page).to have_content("You can tell everyone, you're friends now!!!")
    end
  end
end
