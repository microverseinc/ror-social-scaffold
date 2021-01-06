require 'rails_helper'

RSpec.describe 'Friendship features', type: :request do
  before :each do
    user_one = User.create(name: 'dhoni', email: 'dhoni@dhoni.com', password: '123123')
    user_two = User.create(name: 'Maria', email: 'maria@maria.com', password: '123123')
  end

  scenario 'Create and accept new friendship' do
    visit new_user_session_path
    fill_in 'user_email', with: 'maria@maria.com'
    fill_in 'user_password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')

    visit users_path
    click_link 'Add friend'
    expect(page).to have_content('Friendship request sent!')

    click_link 'Sign out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')

    visit new_user_session_path
    fill_in 'user_email', with: 'dhoni@dhoni.com'
    fill_in 'user_password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')

    visit friendships_path
    click_link 'Accept friend'
    expect(page).to have_content('Friendship request accepted!')
  end

  scenario 'Create and reject new friendship' do
    visit new_user_session_path
    fill_in 'user_email', with: 'maria@maria.com'
    fill_in 'user_password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')

    visit users_path
    click_link 'Add friend'
    expect(page).to have_content('Friendship request sent!')

    click_link 'Sign out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')

    visit new_user_session_path
    fill_in 'user_email', with: 'dhoni@dhoni.com'
    fill_in 'user_password', with: '123123'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')

    visit friendships_path
    click_link 'Reject request'
    expect(page).to have_content('Request rejected!')
  end
end
