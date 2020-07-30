require 'rails_helper'

RSpec.describe 'Sign Up Feature', type: :feature do
  scenario 'user is able to create account' do
    visit new_user_registration_path
    fill_in 'Name', with: 'username1'
    fill_in 'Email', with: 'username1@test.com'
    fill_in 'Password', with: 'testpassword1'
    fill_in 'Password confirmation', with: 'testpassword1'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'non matching passwords raise an error during sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'username1'
    fill_in 'Email', with: 'username1@test.com'
    fill_in 'Password', with: 'testpassword1'
    fill_in 'Password confirmation', with: 'testpassword'
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation doesn\'t match Password")
  end
  scenario 'empty name field raises error during sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: nil
    fill_in 'Email', with: 'username1@test.com'
    fill_in 'Password', with: 'testpassword1'
    fill_in 'Password confirmation', with: 'testpassword1'
    click_button 'Sign up'
    expect(page).to have_content("Name can\'t be blank")
  end
  scenario 'empty email field raises error during sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'userme'
    fill_in 'Email', with: nil
    fill_in 'Password', with: 'testpassword1'
    fill_in 'Password confirmation', with: 'testpassword1'
    click_button 'Sign up'
    expect(page).to have_content("Email can\'t be blank")
  end
  scenario 'empty password field raises error during sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'users021'
    fill_in 'Email', with: 'username12@test.com'
    fill_in 'Password', with: nil
    fill_in 'Password confirmation', with: 'testpassword1'
    click_button 'Sign up'
    expect(page).to have_content("Password can\'t be blank")
  end
end
