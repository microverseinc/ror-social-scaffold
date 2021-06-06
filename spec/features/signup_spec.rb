require 'rails_helper'

RSpec.describe 'Sign Up', type: :feature do
  scenario 'with valid input' do
    visit new_user_registration_path
    fill_in 'Name', with: 'user999'
    fill_in 'Email', with: 'user999@gmail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  scenario 'with invalid input' do
    visit new_user_registration_path
    fill_in 'Name', with: 'user999'
    fill_in 'Email', with: ''
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    visit root_path
    expect(page).to_not have_content("Email can't be blank")
  end
end
