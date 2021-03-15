require 'rails_helper'

RSpec.describe 'posts_controller', type: :system do
  before :each do
    User.create(name: 'angela', email: 'angela@gmail.com', password: '012345', password_confirmation: '012345')
  end

  it 'creates one post' do
    do_login('angela@gmail.com', '012345')
    add_post('Hello')
    expect(page).to have_content 'Hello'
  end
end