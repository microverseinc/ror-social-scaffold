require 'rails_helper'

RSpec.describe 'LoginTests', type: :request do
  let(:user) { User.create(name: 'hello', email: 'hello@hello.com', password: '123456') }

  scenario 'valid login input' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    visit root_path
    expect(page).to have_content(user.name)
  end
end
