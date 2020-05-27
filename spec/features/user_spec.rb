require 'rails_helper'

RSpec.describe 'User session actions', type: :feature do
  before :each do
    User.create(name: 'Oscar', email: "a@mail.com",  password: '123456')
  end

  scenario 'creating a user' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Oscar'
    fill_in 'Email', with: 'a@mail.com'
    fill_in 'Password', with: '123123'
    fill_in 'Password confirmation', with: '123123'
    click_on 'Sign up'
    expect(page).to have_content("Email has already been taken")
  end

  # scenario 'creating a user with duplicate name' do
  #   visit root_path
  #   fill_in 'Name', with: 'Oscar'
  #   click_on 'Submit'
  #   expect(page).to have_content('Error while creating user. Maybe change name?')
  # end

  # scenario 'user logs in successfully' do
  #   visit sessions_new_path
  #   fill_in 'Name', with: 'Oscar'
  #   click_on 'Submit'
  #   expect(page).to have_content('Success: You are now LOGGED IN!')
  # end

  # scenario 'User fails trying to log in' do
  #   visit sessions_new_path
  #   fill_in 'Name', with: 'Inexistent'
  #   click_on 'Submit'
  #   expect(page).to have_content('Who the HECK is Inexistent??? That user name does not EXIST!!')
  # end

  # scenario 'user logs out' do
  #   visit sessions_new_path
  #   fill_in 'Name', with: 'Oscar'
  #   click_on 'Submit'
  #   click_on 'Log out'
  #   expect(page).to have_content('Logged out!')
  # end
end
