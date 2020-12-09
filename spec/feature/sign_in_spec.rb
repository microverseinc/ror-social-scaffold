require 'rails_helper'
RSpec.describe 'Login a user', type: :feature do
  before(:each) do
    @user = User.create(name: 'abc', email: 'a@a.com', password: '123456')
  end
  scenario 'valid inputs' do
    visit user_session_path
    fill_in 'user[email]', with: 'a@a.com'
    fill_in 'user[password]', with: '123456'
    click_on 'Log in'
    visit root_path
    expect(page).to have_content('Recent posts')
  end

  scenario 'Invalid inputs' do
    visit user_session_path
    fill_in 'user[email]', with: 'a@a.co'
    fill_in 'user[password]', with: '123456'
    click_on 'Log in'
    expect(page).to have_content('Invalid Email or password.')
  end
end
