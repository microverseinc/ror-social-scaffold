require 'rails_helper'
RSpec.describe 'Like', type: :feature do
  it 'User can like or dislike a comment or post' do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    visit visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
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
