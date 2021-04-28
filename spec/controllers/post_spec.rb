require 'rails_helper'

feature 'Creating a post', type: :feature do
  feature 'User must login and fill in comment' do
    before(:each) do
      User.create(name: 'foo', email: 'foo@mail.com', password: 'password', password_confirmation: 'password')
      visit '/users/sign_in'
      within('#new_user') do
        fill_in 'Email', with: 'foo@mail.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Log in'
      fill_in 'post_content', with: 'This is a new post.'
      click_button 'commit'
      within('#new_post') do
        fill_in 'post_content', with: 'This is a comment.'
        click_button 'commit'
      end
    end

    scenario 'when you create a new post' do
      expect(page).to have_content('Post was successfully created.')
    end
  end
end
