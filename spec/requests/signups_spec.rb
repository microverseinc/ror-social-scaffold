require 'rails_helper'

RSpec.describe 'Signups', type: :request do
  describe 'GET /new_user_registration_path' do
    it 'works! (Welcome! You have signed up successfully)' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe 'SignUp user', type: :request do
  scenario 'with valid credentials' do
    User.create!(name: 'elijah', email: 'jay@jay.com', password: 'foo1111')
    get new_user_registration_path
    expect(response).to have_http_status(200)
  end

  def sign_up(user)
    fill_in 'Email', with: user.email
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign up'
  end
end
