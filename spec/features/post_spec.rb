require 'rails_helper'
RSpec.describe 'Post', type: :feature do
  before(:each) do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    visit visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click
  end
  it 'User can make a post' do
    fill_in 'post[content]', with: 'This is my post test'
    click_button 'Save'
    expect(page).to have_content('Post was successfully created.')
  end
  it 'User cannot make a blank post' do
    fill_in 'post[content]', with: ''
    click_button 'Save'
    expect(page).to have_content("Content can't be blank")
  end
end
