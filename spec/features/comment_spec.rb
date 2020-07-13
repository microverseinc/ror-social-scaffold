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
    expect(page).to have_content('User')
    fill_in 'comment[content]', with: 'First comment'
    click_on 'Comment'
    expect(page).to have_content('User')
  end
end