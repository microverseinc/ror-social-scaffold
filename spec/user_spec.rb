require 'rails_helper'
require './spec/support/helpers'

feature 'User Authentication' do
  fixtures :users
  background do
    tanzila = User.new(name: 'tanzila', email: 'tanzila@example.com', password: 'password')
    visit new_user_registration_path
    fill_in 'user_name', with: tanzila.name
    fill_in 'user_email', with: tanzila.email
    fill_in 'user_password', with: tanzila.password
    fill_in 'user_password_confirmation', with: tanzila.password
    click_button 'Sign up'
  end

  scenario 'user not logged in' do
    visit root_path
    expect(page).not_to have_link('TIMELINE')
  end

  scenario 'all users page have' do
    visit users_path
    expect(page).to have_content('Name')
    expect(page).to have_link('See Profile')
    expect(page).to have_link('Add Friend')
  end
end
