require 'rails_helper'

RSpec.feature 'Comment creation', type: :feature do
  before :each do
    User.create(name: 'Marios', email: 'b@b.com', password: '000000', password_confirmation: '000000')
    visit 'users/sign_in'
    within('#new_user') do
      fill_in 'user_email', with: 'b@b.com'
      fill_in 'user_password', with: '000000'
    end
    click_button 'commit'
    fill_in 'post_content', with: 'This is an article.'
    click_button 'commit'
    within('#new_comment') do
      fill_in 'comment_content', with: 'This is a comment.'
      click_button 'commit'
    end
  end

  it 'creates a new comment' do
    expect(page).to have_content 'Comment was successfully created.'
  end
end
