require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  let(:user_test) { User.create(name: 'lalo', email: 'lalo@got.com', password: '1234567') }

  before(:example) do
    visit new_user_session_path
  end

  scenario 'User login validation' do
    fill_in 'user_email', with: user_test.email
    fill_in 'user_password', with: user_test.password
    click_on 'Log in'
    expect(page).to have_content('')
  end

  scenario 'User login not valid' do
    fill_in 'user_email', with: 'someemail@email.com'
    fill_in 'user_password', with: 'password'
    click_on 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end

  scenario 'User logout' do
    fill_in 'user_email', with: user_test.email
    fill_in 'user_password', with: user_test.password
    click_on 'Log in'
    click_on 'Sign out'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
