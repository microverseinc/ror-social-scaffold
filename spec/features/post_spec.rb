require 'rails_helper'

feature 'Post actions' do
  before(:example) do
    FactoryBot.create(:user)
    visit '/users/sign_in'
    fill_in 'user_email', with: 'apple@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    fill_in 'post_content', with: 'a Post'
    click_on 'Save'
  end

  scenario 'make new post' do
    fill_in 'post_content', with: 'New Post'
    click_on 'Save'
    expect(page).to have_content 'New Post'
  end

  scenario 'make a comment' do
    fill_in 'comment_content', with: 'a comment'
    click_on 'Comment'
    expect(page).to have_content 'a comment'
  end

  scenario 'Like a post' do
    click_on 'Like!'
    expect(page).to have_content 'Dislike!'
  end

  scenario 'Dislike a post' do
    click_on 'Like!'
    click_on 'Dislike!'
    expect(page).to have_content 'Like!'
  end
end
