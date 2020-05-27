require 'rails_helper'

# RSpec.describe 'User session actions', type: :feature do
#   before :each do
#     create(:user, name: 'Oscar')
#   end

#   scenario 'creating a user' do
#     visit root_path
#     fill_in 'Name', with: 'User test'
#     click_on 'Submit'
#     expect(page).to have_content("User test's Events")
#   end

#   scenario 'creating a user with duplicate name' do
#     visit root_path
#     fill_in 'Name', with: 'Oscar'
#     click_on 'Submit'
#     expect(page).to have_content('Error while creating user. Maybe change name?')
#   end

#   scenario 'user logs in successfully' do
#     visit sessions_new_path
#     fill_in 'Name', with: 'Oscar'
#     click_on 'Submit'
#     expect(page).to have_content('Success: You are now LOGGED IN!')
#   end

#   scenario 'User fails trying to log in' do
#     visit sessions_new_path
#     fill_in 'Name', with: 'Inexistent'
#     click_on 'Submit'
#     expect(page).to have_content('Who the HECK is Inexistent??? That user name does not EXIST!!')
#   end

#   scenario 'user logs out' do
#     visit sessions_new_path
#     fill_in 'Name', with: 'Oscar'
#     click_on 'Submit'
#     click_on 'Log out'
#     expect(page).to have_content('Logged out!')
#   end
# end
