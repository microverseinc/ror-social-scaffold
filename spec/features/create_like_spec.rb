require 'rails_helper'

RSpec.feature 'CreateLikes', type: :feature do
  before :each do
    @user = User.create(name: 'John', email: 'john@mail.com', password: 'password')
    sign_in @user
    @post = Post.create(user: @user, content: 'Hello!')
    visit root_path
  end

  it 'user can create a like' do
    click_link 'Like!'
    expect(current_path).to eq(posts_path)
    expect(page).to have_text('You liked a post.')
  end

  it 'user can destroy a like' do
    click_link 'Like!'
    click_link 'Dislike!'
    expect(current_path).to eq(posts_path)
    expect(page).to have_text('You disliked a post.')
  end
end
