require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Invitation', type: :system do
  describe 'friendship management' do
    before(:each) do
      visit new_user_registration_path
      fill_in 'Name', with: 'Capybara'
      fill_in 'Email', with: 'Capybara@test.com'
      fill_in 'Password', with: 'Capybara1'
      fill_in 'Password confirmation', with: 'Capybara1'
      click_on 'Sign up'
      click_on 'Sign out'

      visit new_user_registration_path
      fill_in 'Name', with: 'Capybara2'
      fill_in 'Email', with: 'Capybara2@test.com'
      fill_in 'Password', with: 'Capybara2'
      fill_in 'Password confirmation', with: 'Capybara2'
      click_on 'Sign up'

      visit users_path
    end

    it 'sends a friendship invitation' do
      click_on 'Invite friend'
      expect(page).to have_content('Awaiting Response')
    end

    it 'confirms a friendship request' do
      click_on 'Invite friend'
      click_on 'Sign out'
      visit new_user_session_path
      fill_in 'Email', with: 'Capybara@test.com'
      fill_in 'Password', with: 'Capybara1'
      click_on 'Log in'
      visit users_path
      click_on 'Accept friendship'
      expect(page).not_to have_content('Accept friendship')
    end

    it 'destroys the request when rejected' do
      click_on 'Invite friend'
      click_on 'Sign out'
      visit new_user_session_path
      fill_in 'Email', with: 'Capybara@test.com'
      fill_in 'Password', with: 'Capybara1'
      click_on 'Log in'
      visit users_path
      click_on 'Reject friendship'
      expect(page).to have_content('Invite Friend')
    end
  end
end
