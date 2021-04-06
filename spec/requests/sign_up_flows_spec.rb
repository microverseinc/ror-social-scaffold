require 'rails_helper'

RSpec.describe 'SignUpFlows', type: :request do
  scenario 'valid signup input' do
    visit new_user_registration_path
    fill_in 'Name', with: 'hello'
    fill_in 'Email', with: 'hello@hello.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    visit root_path
    expect(page).to have_content('hello')
  end
end
