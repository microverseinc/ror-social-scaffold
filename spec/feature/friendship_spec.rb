require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Invitation', type: :system do
  describe "friendship management" do
    before(:each) do
      visit new_user_registration
      fill_in "Name",	with: "Capybara" 
      fill_in "Email",	with: "Capybara@test.com" 
      fill_in "Password",	with: "Capybara1" 
      fill_in "Password confirmation",	with: "Capybara1" 
      click_on 'SIGN UP'
      visit destroy_user_session

      visit new_user_registration
      fill_in "Name",	with: "Capybara2" 
      fill_in "Email",	with: "Capybara2@test.com" 
      fill_in "Password",	with: "Capybara2" 
      fill_in "Password confirmation",	with: "Capybara2" 
      click_on 'SIGN UP'

      visit users_path

    end
    
    it 'sends a friendship invitation' do
      click_on 'Invite friend'
      expect(page).to have_content('awaiting response')
    end


  end
  
end