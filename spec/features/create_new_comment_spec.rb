require 'rails_helper'

RSpec.describe 'Create new comment on post/like a post ', type: :feature do
  before do
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    fill_in :post_content, with: 'My new post'
    click_button 'Save'
  end

  it 'creates a new comment' do
    fill_in :comment_content, with: 'My new comment'
    click_button 'Comment'
  end

  it 'creates an error when creating a new post' do
    fill_in :comment_content, with: ''
    click_button 'Comment'
    expect(page).to have_content('Content can\'t be blank')
  end

  it 'Likes a post' do
    click_link 'Like!'
    expect(page).to have_content('You liked a post.')
  end
end
