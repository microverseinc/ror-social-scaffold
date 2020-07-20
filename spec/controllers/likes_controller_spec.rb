require 'rails_helper'

RSpec.describe 'likes_controller', type: :system do
  before do
    User.create(name: 'Taofeek', email: 'taofeek@gmail.com', password: '123456',
                password_confirmation: '123456')
  end

  it 'creates a new post' do
    do_login('taofeek@gmail.com', '123456')
    create_post('This is a valid post')
    expect(page).to have_content('Post was successfully created')
  end

  it 'likes a particular post' do
    like('taofeek@gmail.com', '123456', 'This is a valid post')
    expect(page).to have_content('You liked a post')
  end

  it 'dislikes an already liked post' do
    like('taofeek@gmail.com', '123456', 'This is a valid post')
    click_link('Dislike!')
    expect(page).to have_content('You disliked a post')
  end
end
