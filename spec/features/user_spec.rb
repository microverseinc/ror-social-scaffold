require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'login' do
    visit new_user_session_path
    within('form') do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      click_on 'Log in'
    end
    expect(page).to have_text('Signed in successfully.')
  end
end
