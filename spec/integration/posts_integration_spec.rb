require 'rails_helper'
require 'spec_helper'

# rubocop:disable  Metrics/BlockLength

RSpec.describe PostsController, type: :feature do
  context 'timeline displays friends posts' do
    let(:user) { User.create(id: '1', name: 'JonDoe', email: 'JonDoe@mail.com', password: 'password') }

    scenario 'current_user posts' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      fill_in 'post_content', with: 'Create a post for testing'
      click_button 'Save'
      visit root_path
      expect(page).to have_content('Create a post for testing')
    end

    scenario 'friends posts' do
      user2 = User.create(id: '2', name: 'JaneDoe', email: 'JaneDoe@mail.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      visit users_path
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'Log in'
      visit root_path
      fill_in 'post_content', with: 'Add posts with For testing and For your friend'
      click_button 'Save'
      sleep(2)
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
    end

    scenario 'Posts are hidden if not mutual friendship' do
      user2 = User.create(id: '2', name: 'Angel', email: 'angel@example.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'Log in'
      visit root_path
      fill_in 'post_content', with: 'Testing posts with rspec in rails and I am a friend'
      click_button 'Save'
      sleep(2)
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).not_to have_content('Angel And You Are Friends')
    end
  end

  # rubocop:enable  Metrics/BlockLength
end
