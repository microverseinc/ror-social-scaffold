require 'rails_helper'

RSpec.feature 'SignIns', type: :feature do
  scenario "is expected to fail if the user doesn't exist" do
    visit('/users/sign_in')
    within('form') do
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'user_password', with: '365214'
    end
    click_button 'Log in'
    expect(page).not_to have_content 'Signed in successfully.'
  end

  scenario 'is expected to succeed if the user exists' do
    visit('/users/sign_up')
    within('form') do
      fill_in 'Name', with: 'testuser'
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'Password', with: '365214'
      fill_in 'Password confirmation', with: '365214'
      click_button 'SIGN UP'
    end
    visit '/'
    click_link 'Sign out'

    visit('/users/sign_in')
    within('form') do
      fill_in 'Email', with: 'testuser@email.com'
      fill_in 'user_password', with: '365214'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
