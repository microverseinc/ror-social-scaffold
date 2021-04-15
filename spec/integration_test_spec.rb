require 'rails_helper'

RSpec.describe 'User Authentication', type: :system do
  describe 'root page' do
    it 'allows user to create new account' do
      visit root_path
      click_link "Sign up"
      fill_in "Name", with: 'New User'
      fill_in "Email", with: 'new_user@email.com'
      fill_in "Password", with: 'abc123'
      fill_in "Password confirmation", with: 'abc123'
      click_button "Sign up"
      expect(page).to have_content('NEW USER')
    end

    it 'allows user to sign in and sign out' do
      visit root_path
      fill_in "Email", with: 'new_user@email.com'
      fill_in "Password", with: 'abc123'
      click_button "Log in"
      expect(page).to have_content('NEW USER')
      click_link "Sign out"
      expect(page).to have_content('Sign in')
    end
  end
end


RSpec.describe 'Post Features', type: :system do
  it 'allows user to create a new post' do
    visit root_path
    click_link "Sign up"
    fill_in "Name", with: 'John Smith'
    fill_in "Email", with: 'john.smith@email.com'
    fill_in "Password", with: 'abc123'
    fill_in "Password confirmation", with: 'abc123'
    click_button "Sign up"
    fill_in "Content", with: 'This is a test'
    click_button "Save"
    expect(page).to have_content('This is a test')
  end
end