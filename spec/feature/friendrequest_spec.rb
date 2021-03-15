require 'rails_helper'

RSpec.describe 'friendrequests_controller', type: :system do
  before :each do
    User.create(name: 'sharon', email: 'sharon@gmail.com', password: '012345', password_confirmation: '012345')
    User.create(name: 'angela', email: 'angela@gmail.com', password: '012345', password_confirmation: '012345')
  end

  it 'adds a friend' do
    do_login('sharon@gmail.com', '012345')
    send_request
    expect(page).to have_content 'Friends Request Sent'
  end

  it 'accepts friend request' do
    do_login('sharon@gmail.com', '012345')
    send_request
    do_logout
    do_login('angela@gmail.com', '012345')
    confirm_friend
    expect(page).to have_content 'Your Friend'
  end

  it 'rejects friend request' do
    do_login('sharon@gmail.com', '012345')
    send_request
    do_logout
    do_login('angela@gmail.com', '012345')
    reject_friend
    expect(page).to have_button('Add friend')
  end

  it 'lists all friends of user' do
    do_login('sharon@gmail.com', '012345')
    send_request
    do_logout
    do_login('angela@gmail.com', '012345')
    confirm_friend
    click_link('Friends')
    expect(page).to have_content 'sharon'
  end
end
