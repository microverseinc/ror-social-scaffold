require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  before :each do
    @author = User.create(name: 'Emma', email: 'emma@mail.com', password: '123456')
    @user = User.create(name: 'Alex', email: 'alex@mail.com', password: '123456')
    @post = Post.create(content: 'Alex\'s first post on stay in touch.', user_id: @author.id)
  end

  it 'creates a comment' do
    visit user_session_path
    fill_in 'user[email]', with: @author.email
    fill_in 'user[password]', with: @author.password
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Recent posts')
    expect(page).to have_content(@user.name)
    expect(page).to have_content(@post.content)
    fill_in 'comment[content]', with: 'I love your post.'
    click_button 'Comment'
    expect(page).to have_content('Comment was successfully created.')
    expect(page).to have_content('COMMENTS: 1')
    expect(page).to have_content('Emma: I love your post.')
  end
end
