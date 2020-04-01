require 'rails_helper'

RSpec.feature 'Sessions', type: :feature do
  let!(:user) do
    User.create(
      name: 'amadou',
      email: 'amadou@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  describe 'Sign in the user' do
    before do
      visit new_user_session_path
    end

    it 'shows login form' do
      have_link 'Forgot your password?', href: new_user_password_path
      have_link 'Sign Up', href: new_user_registration_path
      expect(page).to have_content('Sign in')
    end

    it 'sign in the user ' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page).to have_content(user.name.to_s)
      expect(page).to have_content('Signed in successfully')
      expect(current_path).to eq root_path
      have_link 'Sign out', href: destroy_user_session_path
    end

    it 'Show error for wrong credentials' do
      fill_in 'Email', with: 'juda@juda.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      expect(page).to have_content('Sign in')
      expect(current_path).to eq new_user_session_path
      have_link 'Forgot your password?', href: new_user_password_path
      have_link 'Sign Up', href: new_user_registration_path
      expect(page).to have_text 'Invalid Email or password.'
    end
  end

  describe 'Sign out the user ', type: :feature do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    context 'log out the user' do
      before do
        expect(current_path).to eq root_path
        have_link 'Sign out', href: destroy_user_session_path
        click_on 'Sign out'
      end
      it 'go on the root page' do
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end
