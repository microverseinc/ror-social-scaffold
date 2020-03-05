require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let(:user_valid) do
    has_x = { name: 'elijah', email: 'elijah@gmail.com' }
    has_x[:password] = 'elijah'
    has_x[:password_confirmation] = 'elijah'

    has_x
  end

  scenario 'post should display author in timeline' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    visit root_path
    some_text = 'This is a comment'
    fill_in 'post_content', with: some_text
    find('[type=submit]').click

    expect(page).to have_content some_text
    expect(page).to have_content user.name
  end

  scenario 'post should display likes on timeline' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    post = user.posts.create(content: 'this is a post')
    comment = post.comments.create(content: 'this is a comment',
                                   user_id: user.id)
    user.likes.create(post_id: post.id)

    visit root_path
    expect(page).to have_content comment.content
    expect(page).to have_content 'Dislike!'
  end

  scenario 'user can create a comment in a post' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    find('[type=submit]').click

    user.posts.create(content: 'this is a post')
    visit root_path
    example_comment = 'Example_comment'
    fill_in 'comment_content', with: example_comment
    click_button 'Comment'
    expect(page).to have_content(example_comment)
  end
end
