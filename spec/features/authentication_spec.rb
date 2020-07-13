require 'rails_helper'
# rubocop: disable Metrics/BlockLength
RSpec.feature 'Authentications', type: :feature do
  before :each do
    @user = User.create(name: 'user', email: 'user@mail.com', password: 'password', password_confirmation: 'password')
  end

  it 'Should Signup' do
    visit new_user_registration_path
    fill_in 'user_email', with: 'newuser@mail.com'
    fill_in 'user_name', with: 'newuser'
    fill_in 'user_password', with: 'passwordd'
    fill_in 'user_password_confirmation', with: 'passwordd'
    click_button 'Sign up'
    expect(page).to have_content('Stay in touch')
    expect(page).to have_content('Timeline')
    expect(page).to have_content('Sign out')
  end

  it 'Should Signin' do
    visit root_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Stay in touch')
    expect(page).to have_content('Timeline')
    expect(page).to have_content('Sign out')
  end

  it 'Should Signout' do
    visit root_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: 'password'
    click_button 'Log in'
    expect(page).to have_content('Stay in touch')
    expect(page).to have_content('Timeline')
    expect(page).to have_content('Sign out')
    click_on 'Sign out'
    expect(page).to have_content('Stay in touch')
    expect(page).to have_content('Timeline')
    expect(page).to have_content('Sign in')
  end
end
# rubocop: enable Metrics/BlockLength
