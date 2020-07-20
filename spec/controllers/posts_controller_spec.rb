require 'rails_helper'

RSpec.describe 'posts_controller', type: :system do
  before do
    User.create(name: 'Taofeek', email: 'taofeek@gmail.com', password: '123456',
                password_confirmation: '123456')
  end

  it 'creates a new post' do
    do_login('taofeek@gmail.com', '123456')
    create_post('This is a valid post')
    expect(page).to have_content('Post was successfully created')
  end
end
