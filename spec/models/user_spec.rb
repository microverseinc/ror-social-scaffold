require 'rails_helper'

RSpec.describe User, type: :feature do
  before :each do
    User.create(name: 'JonDoe', email: 'jondoe@example.com', password: 'password', password_confirmation: 'password')
  end

  it 'Verifies user' do
    expect(User.last.name).to have_content 'JonDoe'
  end

  it 'Signs user in' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'jondoe@example.com'
      fill_in 'user_password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end
