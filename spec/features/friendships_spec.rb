require 'rails_helper'

RSpec.feature 'Friendship' do
  let!(:user) { create(:random_user) }
  let!(:friend) { create(:random_friend) }

  context 'User adds a friend and' do
    it 'the request is sent successfully' do
      login_user(user)
      visit root_path
      click_link 'All users'
      within 'ul' do
        within('li', text: friend.name) do
          click_link 'Request Friendship'
          sleep(2)
        end
      end
      expect(page).to have_content('You sent a friend request!')
    end

    it 'friend request is accepted' do
      create(:unconfirmed_friendship)
      login_user(friend)
      visit root_path
      click_link 'All users'
      within 'ul' do
        within('li', text: user.name) do
          click_button 'Accept friendship'
          sleep(2)
        end
      end
      expect(page).to have_content('You\'re already friends!')
    end
  end
end
