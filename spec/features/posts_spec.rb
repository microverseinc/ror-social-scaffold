require 'rails_helper'

RSpec.feature 'Posts:', type: :feature do
  let(:user) { User.create(name: 'Franklin', email: 'franklin@gmail.com', password: '12345678') }
  scenario 'Creates a new valid post' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'Enduring the crisis'
    click_on 'Save'
    expect(page).to have_content('Enduring the crisis')
  end

  scenario 'Creates an invalid post' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: ''
    click_on 'Save'
    expect(page).to_not have_content('Enduring the crisis')
  end
end
