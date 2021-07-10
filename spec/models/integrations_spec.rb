require 'rails_helper'
require 'capybara/rails'
# rubocop:disable Lint/UselessAssignment
RSpec.describe 'Integrations', type: :system do
  describe 'Timeline' do
    it 'Shows timeline after Log In' do
      user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd', name: 'Test Account')
      login_as(user, scope: :user)
      visit root_path
      sleep(1)
      expect(page).to have_content('Recent posts')
    end

    it 'Shows Log In page if you try to access timeline without Log In' do
      visit root_path
      sleep(1)
      expect(page).to have_content('SIGN IN')
    end

    it 'Posting action' do
      user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd', name: 'Test Account')
      login_as(user, scope: :user)
      visit Capybara.app_host
      fill_in 'Content', with: 'Integration Test Post'
      click_on 'Save'
      sleep(1)
      expect(page).to have_content('Integration Test Post')
    end

    it 'Tests User friendship request button' do
      user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd', name: 'Test Account')
      user2 = User.create!(email: 'test2@example.com', password: 'f4k3p455w0rd', name: 'Test Account 2')
      login_as(user, scope: :user)
      visit Capybara.app_host
      click_on 'All users'
      sleep(1)
      click_on 'Add Friend'
      sleep(1)
      expect(page).to have_content('Cancel Request')
    end

    it 'Tests User Profile Show page' do
      user = User.create!(email: 'test@example.com', password: 'f4k3p455w0rd', name: 'Test Account')
      user2 = User.create!(email: 'test2@example.com', password: 'f4k3p455w0rd', name: 'Test Account 2')
      login_as(user, scope: :user)
      visit("/users/#{user2.id}")
      sleep(3)
      expect(page).to have_content(user2.name)
    end
  end
end
# rubocop:enable Lint/UselessAssignment
