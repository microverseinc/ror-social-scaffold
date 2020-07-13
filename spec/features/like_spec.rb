require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  before :each do
    @user = User.create(name: 'User', email: 'user@mail.com', password: '1234567')
    @post = Post.create(content: 'An awesome post', user_id: @user.id)
  end

  it 'Should create comment' do
    visit root_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: '1234567'
    click_button 'Log in'
    click_on 'Like!'
    expect(page).to have_content('Dislike!')
  end

  it 'Should delete a like from a post' do
    visit root_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: '1234567'
    click_button 'Log in'
    click_on 'Like!'
    expect(page).to have_content('Dislike!')
    click_on 'Dislike!'
    expect(page).to have_content('Like!')
  end
end
