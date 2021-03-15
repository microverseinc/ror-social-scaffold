require 'rails_helper'

RSpec.describe 'users_controller', type: :system do
  before :each do
    User.create(name: 'angela', email: 'angela@gmail.com', password: '012345', password_confirmation: '012345')
  end

  it 'signs up  a user' do
    do_signup('angela', 'angela23@gmail.com', '012345')
    expect(page).to have_content 'Recent posts'
  end

  it 'logs in a user' do
    do_login('angela@gmail.com', '012345')
    expect(page).to have_content 'Recent posts'
  end

  it 'logs out a user' do
    do_login('angela@gmail.com', '012345')
    do_logout
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end
end