require 'rails_helper'
RSpec.describe 'Comment', type: :feature do
  it 'User can make and save comment' do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass', password_confirmation: 'secretpass')
    visit  visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click

    fill_in 'post[content]', with: 'This is my post test'
    click_button 'Save'

    fill_in 'comment[content]', with: 'This is my comment test'
    click_button 'Comment'

    expect(page).to have_content('Comment was successfully created.') 
  end
end
