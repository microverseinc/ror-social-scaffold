require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :feature do
  let(:user1) { User.new(name: 'JonDoe', email: 'JonDoe@gmail.com', password: 'password') }
  scenario 'User has registered successfully' do
    visit new_user_registration_path
    fill_in 'Name', with: 'test name'
    fill_in 'Email', with: 'testname@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  scenario 'User has Signed in successfully' do
    user1.save
    visit root_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end
