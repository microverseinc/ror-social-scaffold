require 'rails_helper'

RSpec.describe 'login page', type: :feature do
  let(:user) do
    User.create(name: 'Gaby', email: 'gaby@gmail.com',
                password: 'foobar', password_confirmation: 'foobar')
  end
  scenario 'login' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully')
  end
end
