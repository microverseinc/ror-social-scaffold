require 'rails_helper'

RSpec.describe 'Authentication Feature', type: :feature do
  let(:user) { User.new(name: 'test', email: 'test@email.com', password: 'testing') }
  let(:post) { Post.new(content: 'This is a test!') }

  scenario 'Only logged in user can create a post' do
    user.save
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    fill_in 'Content', with: 'This is a test post'
    click_button 'Save'
    expect(page).to have_content('Post was successfully created.')
  end

  scenario 'Only logged in user can create a comment, post and like' do
    visit root_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
