require 'rails_helper'
require 'capybara/rspec'

RSpec.describe FriendshipsController, type: :feature do
  context 'timeline displays friends posts' do
    let(:user1) { User.create(id: '2', name: 'Ramin', email: 'ramin@ramin.com', password: '123456') }
    let(:user2) { User.create(id: '3', name: 'Jurgen', email: 'jurgen@jurgen.com', password: '654321') }

    before :each do
      visit new_user_session_path
      fill_in 'user_email', with: user1.email
      fill_in 'user_password', with: user1.password
      click_button 'Log in'
    end

    scenario 'send friend request (add friend)' do
      visit '/users'
      expect(page).to have_content(user1.name)
    end

    scenario 'send friend request (add friend)' do
      visit "/users/#{user1.id}"
      expect(page).to have_content("Name: #{user1.name}")
    end
  end
end
