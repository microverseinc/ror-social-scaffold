require 'rails_helper'

describe 'creating a new user' do
  it 'creates a user and signs in' do
    visit root_url
    click_link 'Sign up'
    expect(current_path).to eq(new_user_registration_path)
    fill_in 'user_name', with: 'Sami'
    fill_in 'user_email', with: 'sami@sami.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'

    click_button 'commit'
    expect(current_path).to eq(root_path)

    expect(page).to have_text('Welcome! You have signed up successfully.')
    expect(page).to have_text('Sami')
  end

  it 'does not create user if it is balck/empty' do
    visit new_user_registration_url
    click_button 'commit'
    expect(page).to have_text('3 errors prohibited this user from being saved:')
  end
end
