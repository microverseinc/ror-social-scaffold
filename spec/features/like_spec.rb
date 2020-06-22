require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  before :each do
    @user_like = User.create(name: 'Emma', email: 'emma@mail.com', password: '123456')
    @user = User.create(name: 'Alex', email: 'alex@mail.com', password: '123456')
    @post = Post.create(content: 'Alex\'s first post on stay in touch.', user_id: @user_like.id)
  end

  it 'creates a like' do
    visit user_session_path
    fill_in 'user[email]', with: @user_like.email
    fill_in 'user[password]', with: @user_like.password
    click_button 'Log in'
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.content)
    expect(page).to have_content('Like!')
    click_on 'Like!'
    expect(page).to have_content('You liked a post.')
  end

  it 'deletes a like' do
    visit user_session_path
    fill_in 'user[email]', with: @user_like.email
    fill_in 'user[password]', with: @user_like.password
    click_button 'Log in'
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.content)
    expect(page).to have_content('Like!')
    click_on 'Like!'
    expect(page).to have_content('You liked a post.')
    expect(page).to have_content('Dislike!')
    click_on 'Dislike'
    expect(page).to have_content('You disliked a post.')
  end
end
