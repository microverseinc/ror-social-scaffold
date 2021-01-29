require 'rails_helper'

RSpec.describe 'forgot password', type: :feature do
  before(:each) do
    User.create(email: 'user@example.com', name: 'user', password: 'password')
  end
  it 'returns success if correct email' do
    visit '/users/password/new'
    within('#new_user') do
      fill_in 'Email', with: 'user@example.com'
    end
    click_button 'Send me reset password instructions'
    expect(page.status_code).to be(200)
    expect(current_path).to eq('/users/sign_in')
  end

  it 'raise error if email incorrect or does not exists' do
    visit '/users/password/new'
    within('#new_user') do
      fill_in 'Email', with: 'user@asd.com'
    end
    click_button 'Send me reset password instructions'
    expect(page).to have_content 'Email not found'
  end

  it 'raise error if email blank' do
    visit '/users/password/new'
    within('#new_user') do
      fill_in 'Email', with: ''
    end
    click_button 'Send me reset password instructions'
    expect(page).to have_content "Email can't be blank"
  end
end
