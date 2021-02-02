require 'rails_helper'

RSpec.describe 'Sing in & out ', type: :feature do
  before do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'logs me into the page' do
    expect(page).to have_content 'Sign out'
  end

  it 'logs me into the page' do
    click_link('Sign out')
    expect(page).to have_content 'Sign in'
  end
end
