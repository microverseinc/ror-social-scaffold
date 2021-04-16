require 'rails_helper'

RSpec.feature 'CreatePosts', type: :feature do
  before :each do
    @user = User.create(name: 'John', email: 'john@mail.com', password: 'password')
    sign_in @user
    @post = Post.new(user: @user, content: 'Hello!')
    visit root_path
  end

  it 'user can create a post' do
    fill_in 'post_content', with: @post.content
    click_button 'Save'
    expect(current_path).to eq(posts_path)
    expect(page).to have_text('Post was successfully created.')
  end
end
