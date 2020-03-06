require 'spec_helper'
require 'rails_helper'

RSpec.describe 'Integration tests for the user controller', type: :feature do
  let(:test_user) {
    User.new(name: 'test_user', email: 'test@user.com',
             password: 'secret', password_confirmation: 'secret') }
  let(:test_user_2) {
    User.new(name: 'test_user_2', email: 'test2@user.com',
             password: 'secret', password_confirmation: 'secret') }

  def store_in_database
    test_user.save
    test_user_2.save
  end

  def log_in
    visit users_path
    fill_in 'Email', with: test_user.email
    fill_in 'Password', with: test_user.password
    click_button 'Log in'
  end

  scenario 'displaying all the users' do
    store_in_database
    log_in
    expect(page).to have_selector 'li', text: 'test_user_2'
  end

  scenario "'See profile' button shows the right user" do
    store_in_database
    log_in
    click_link("user-#{test_user_2.id}")
    expect(page).to have_selector 'h2', text: "#{test_user.name}"
  end
end