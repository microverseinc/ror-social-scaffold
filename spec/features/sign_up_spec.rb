require 'rails_helper'

RSpec.feature 'SignUps', type: :feature do
  scenario 'is expected to succeed if all are filled out' do
    visit('/users/sign_up')
    within('form') do
      fill_in 'Name', with: 'First'
      fill_in 'Email', with: 'firstuser@email.com'
      fill_in 'Password', with: '654321'
      fill_in 'Password confirmation', with: '654321'
    end
    click_button 'SIGN UP'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
  scenario 'is expected to fail if password and password confirmation fields missmatch' do
    visit('/users/sign_up')
    within('form') do
      fill_in 'Name', with: 'First User'
      fill_in 'Email', with: 'firstuser@gmail.com'
      fill_in 'Password', with: '654321'
      fill_in 'Password confirmation', with: '123456'
    end
    click_button 'SIGN UP'
    expect(page).not_to have_content 'Welcome! You have signed up successfully.'
  end
end
