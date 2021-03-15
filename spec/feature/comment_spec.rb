require 'rails_helper'

RSpec.describe 'comments_controller', type: :system do
  before :each do
    User.create(name: 'angela', email: 'angela23@gmail.com', password: '012345', password_confirmation: '012345')
  end

  it 'creates one comment' do
    do_login('angela12@gmail.com', '012345')
    add_post('Hello')
    add_comment('Hello, too!')
    expect(page).to have_content 'Hello, too!'
  end
end
