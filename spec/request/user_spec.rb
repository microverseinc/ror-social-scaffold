require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  before do
    @user = User.create(name: 'Random Guy', email: 'r@mail.com', password: 'foobar')
  end

  scenario 'if registered, can login' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(find('.notice')).to have_content('Signed in successfully.')
  end
end
