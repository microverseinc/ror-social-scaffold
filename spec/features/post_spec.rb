require 'rails_helper'
RSpec.feature 'Post', type: :feature do
  before(:each) do
    User.create(name: 'Alex', email: 'alex@gmail.com', password: '123456',
                password_confirmation: '123456')
    visit new_user_session_path
    fill_in 'user_email', with: 'alex@gmail.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click
  end
  it 'User can make a post' do
    fill_in 'post[content]', with: 'This is a post for testing'
    click_button 'Save'
    expect(page).to have_content('Post was successfully created.')
  end
  it 'User cannot make a blank post' do
    fill_in 'post[content]', with: ''
    click_button 'Save'
    expect(page).to have_content("Content can't be blank")
  end
end
