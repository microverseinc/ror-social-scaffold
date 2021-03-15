require 'rails_helper'

RSpec.describe 'likes_controller', type: :system do
  before :each do
    User.create(name: 'angela', email: 'angela@gmail.com', password: '012345', password_confirmation: '012345')
  end

  it 'likes one post' do
    do_login('angela@gmail.com', '012345')
    add_post('Hello')
    like_post('/posts/1/likes')
    expect(page).to have_content '1 Like'
    expect(page).to have_content 'Dislike!'
  end

  it 'dislikes one post' do
    do_login('angela@gmail.com', '012345')
    add_post('Hello')
    like_post('/posts/1/likes')
    dislike_post('/posts/1/likes/1')
    expect(page).to have_content 'Like!'
  end
end
