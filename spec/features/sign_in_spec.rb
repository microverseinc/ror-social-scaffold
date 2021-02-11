require 'rails_helper'

RSpec.describe 'SignIns', type: :feature do
  before do
    visit new_user_session_path
  end

  it 'redirects to root path after signing in' do
    user = create(:user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_current_path(root_path)
  end

  it 'shows error if fields are invalid' do
    fill_in 'Email', with: 'hello@examp'
    fill_in 'Password', with: 'hello'
    click_button 'Log in'

    expect(page).to have_text('Invalid')
  end
end
