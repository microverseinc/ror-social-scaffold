require 'rails_helper'
RSpec.describe 'Like', type: :feature do
  it 'User can like or dislike a comment or post' do
    User.create(name: 'Alex', email: 'alex@gmail.com', password: '123456',
                password_confirmation: '123456')
    visit new_user_session_path
    fill_in 'user_email', with: 'alex@gmail.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click

    fill_in 'post[content]', with: 'This is my post test'
    click_button 'Save'

    fill_in 'comment[content]', with: 'This is my comment test'
    click_button 'Comment'

    click_link 'Like!'

    expect(page).to have_content('Dislike!')

    click_link 'Dislike!'

    expect(page).to have_content('Like!')
  end
end
