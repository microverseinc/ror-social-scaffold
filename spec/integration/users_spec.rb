require 'rails_helper'

RSpec.describe 'Users >', type: :feature do
  let(:user_a) { User.new(name: 'Mohammed', email: 'mohammed@email.com', password: 'qwerty') }
  let(:user_b) { User.new(name: 'Jesus', email: 'jesus@email.com', password: 'qwerty') }

  def sign_up(user)
    visit new_user_registration_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
  end

  def log_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  feature 'Sign up >' do
    scenario 'Sign up with valid information' do
      sign_up(user_a)

      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  feature 'Sign in >' do
    scenario 'Sign in with valid credentials' do
      sign_up(user_a)
      click_on 'Sign out'
      log_in(user_a)

      expect(page).to have_content('Signed in successfully.')
    end

    scenario 'Try to Sign in with invalid credentials' do
      visit new_user_session_path
      fill_in 'Email', with: 'not_a_user@email.com'
      fill_in 'Password', with: 'h@ck3r'
      click_on 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end
  end
end
