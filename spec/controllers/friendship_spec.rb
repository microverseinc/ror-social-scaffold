require 'rails_helper'

feature 'Add new friends', type: :feature do
  feature 'Login an existing user' do
    let(:user1) do
      User.create(name: 'Foo', email: 'foo@mail.com', password: 'password', password_confirmation: 'password')
    end
    let(:user2) do
      User.create(name: 'Bar', email: 'bar@mail.com', password: 'password', password_confirmation: 'password')
    end

    before(:each) do
      user1
      user2
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'foo@mail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      visit '/users'
    end

    scenario 'see all users' do
      expect(page).to have_content('See Profile')
    end

    scenario 'allows users to send friend requests' do
      Friendship.create(user_id: user2.id, friend_id: user1.id)
      click_button('Invite to friendship')
      expect(page).to have_content('Friend Invitation has been sent.')
    end
  end
end
