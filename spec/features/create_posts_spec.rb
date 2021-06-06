require 'rails_helper'

RSpec.describe 'Create Post', type: :feature do
  let(:user) { User.create(name: 'User999', email: 'user999@gmail.com', password: '123456') }
  scenario 'with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    visit root_path
    fill_in 'Content', with: 'Sample Post'
    click_on 'Save'
    expect(page).to have_content('Post was successfully created.')
  end

  scenario 'with blank inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    visit root_path
    fill_in 'Content', with: ''
    click_on 'Save'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
  end
end
