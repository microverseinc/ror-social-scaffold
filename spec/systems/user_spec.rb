require 'rails_helper'

RSpec.describe 'Users management', type: :system do
  let(:user) { User.new(name: 'John Doe', email: 'johndoe@email.com', password: 'password') }

  it 'creates a new user' do
    visit new_user_registration_path
    fill_in 'user[name]', with: 'John Doe'
    fill_in 'user[email]', with: 'johndoe@example.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button('commit')

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  describe 'session management' do
    before do
      user.save!
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button('commit')
    end

    it 'signs in new user' do
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('SIGN OUT')
    end

    it 'signs out user' do
      click_link('Sign out')
      expect(page).to have_content('You need to sign in or sign up before continuing.')
    end
  end
end
