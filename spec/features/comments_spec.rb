require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let(:user) { User.create(name: 'Franklin', email: 'franklin@gmail.com', password: '12345678') }
  scenario 'Create vaild comment' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'This is my first post!'
    click_on 'Save'
    fill_in :comment_content, with: 'congrats!'
    click_on 'Comment'
    expect(page).to have_content('congrats!')
  end

  scenario 'create comment invalid' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    fill_in :post_content, with: 'This is my first post!'
    click_on 'Save'
    fill_in :comment_content, with: ''
    click_on 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
end
