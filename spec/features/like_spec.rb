require 'rails_helper'

RSpec.describe 'Like features', type: :request do
  scenario 'Like and dislike testing' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'tadeu'
    fill_in 'user_email', with: 'tadeu@tadeu.com'
    fill_in 'user_password', with: '123123'
    fill_in 'user_password_confirmation', with: '123123'
    click_button 'Sign up'

    visit posts_path
    fill_in 'post_content', with: 'Some random text'
    click_button 'Save'
    expect(page).to have_content('Post was successfully created.')

    visit posts_path
    fill_in 'comment_content', with: 'This is some comment'
    click_button 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end
end
