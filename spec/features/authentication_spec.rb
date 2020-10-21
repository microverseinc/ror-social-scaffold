require 'rails_helper'
RSpec.describe 'User', type: :feature do
  it 'It should create a new user' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'Ibe Precious'
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    fill_in 'user_password_confirmation', with: 'secretpass'
    find("input[type='submit']").click
    expect(page).to have_content(/Welcome! You have signed up successfully./i)
  end

  it 'It should sign in a user' do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    visit visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click
    expect(page).to have_content(/Signed in successfully./i)
  end

  it 'It should not sign in a user without email or password' do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    visit visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: ''
    find("input[type='submit']").click
    expect(page).to have_content(/Invalid Email or password./i)
  end
end
