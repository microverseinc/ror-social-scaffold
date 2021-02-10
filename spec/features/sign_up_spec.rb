require 'rails_helper'

RSpec.describe 'SignUps', type: :feature do
  before { visit new_user_registration_path }

  it 'redirects to root path after signing up' do
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'hello@example.com'
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_button 'Sign up'

    expect(page).to have_current_path(root_path)
  end

  it 'shows error message if fields are not valid' do
    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: ''
    fill_in 'Password', with: 'hello123'
    fill_in 'Password confirmation', with: 'hello123'
    click_button 'Sign up'

    expect(page).to have_text("Email can't be blank")
  end
end
