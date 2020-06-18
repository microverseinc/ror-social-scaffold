require 'spec_helper'

RSpec.describe 'login followed by logout', type: :feature do
  # The user must exist so we are creating it here
  let(:user) { User.create(email: 'shubham@gmail.com', name: 'Shubham Singh', password: 'minglecup') }

  scenario 'login page' do
    visit root_path
    fill_in 'user_email', with: user.email

    fill_in 'user_password', with: user.password
    click_button 'Log in'
    sleep(3)
    expect(page).to have_content('Signed in successfully')

    click_on 'Sign out'
    sleep(3)
    expect(page). to have_content('You need to sign in or sign up before continuing')
  end
end
