require 'rails_helper'

RSpec.describe 'Registration', type: :system do
  let(:user) do
    User.create(name: 'example_user',
                email: 'user@example.com',
                password: '123456',
                password_confirmation: '123456')
  end

  context 'user sign up' do
    it 'registers a new user into the users table' do
      visit('/users/sign_up')
      fill_in('user[name]', with: 'guiguito')
      fill_in('user[email]', with: 'guiguito@example.com')
      fill_in('user[password]', with: 'password')
      fill_in('user[password_confirmation]', with: 'password')
      sleep(2)
      click_button('Sign up')
      sleep(3)
      expect(page).to have_content('Welcome! You have signed up successfully')
    end
  end

  context 'user log in & create post' do
    it 'logs in an already registered user' do
      visit('/users/sign_in')
      fill_in('user[email]', with: user.email)
      fill_in('user[password]', with: user.password)
      sleep(2)
      click_button('Log in')
      sleep(3)
      expect(page).to have_content('Signed in successfully')

      fill_in('post[content]', with: 'Example Post')
      click_button('Save')
      sleep(3)
      click_link('Sign out')
      expect(page).to have_content('You need to sign in or sign up before continuing')
      sleep(3)
    end
  end
end
