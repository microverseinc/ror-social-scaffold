require 'rails_helper'

RSpec.describe 'Signin', type: :request do
  describe 'GET /new_user_session_path' do
    it 'works! (Signed in successfully)' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end
end

RSpec.describe 'User signin', type: :request do
  scenario 'sign in user with correct user details' do
    User.create!(name: 'carl', email: 'carl@carl', password: 'carlbond')
    get new_user_session_path
    expect(response).to have_http_status(200)
  end

  def signin(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end