require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  before :each do
    @user = User.create(name: 'User', email: 'user@mail.com', password: '1234567')
    @post = Post.create(content: 'An awesome post', user_id: @user.id)
  end

  it 'Should create a post' do
    visit new_user_session_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: '1234567'
    click_button 'Log in'
    fill_in 'post[content]', with: 'This is a post content'
    click_on 'Save'
    expect(page).to have_content('This is a post content')
  end
end
