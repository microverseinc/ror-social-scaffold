require 'rails_helper'

RSpec.describe 'Create new posts ', type: :feature do
  before do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  it 'creates a new post' do
    fill_in :post_content, with: 'My new post'
    click_button 'Save'
  end

  it 'creates an error when creating a new post' do
    fill_in :post_content, with: ''
    click_button 'Save'
    expect(page).to have_content('Post could not be saved. Content can\'t be blank')
  end
end
