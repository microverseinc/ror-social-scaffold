require 'rails_helper'

RSpec.feature 'CreateComments', type: :feature do
  before :each do
    @user = User.create(name: 'John', email: 'john@mail.com', password: 'password')
    sign_in @user
    @post = Post.create(user: @user, content: 'Hello!')
    visit root_path
  end

  it 'user can create a comment' do
    fill_in 'comment_content', with: 'Hello Again!'
    click_button 'Comment'
    expect(current_path).to eq(posts_path)
    expect(page).to have_text('Comment was successfully created.')
  end
end
