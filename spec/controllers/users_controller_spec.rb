require 'rails_helper'

RSpec.describe 'users_controller', type: :system do
  before :each do
    User.create(name: 'Taofeek', email: 'taofeek@gmail.com', password: '123456', password_confirmation: '123456')
    User.create(name: 'Teeboy', email: 'teeboy@gmail.com', password: '123456', password_confirmation: '123456')
  end

  it 'sends an invitation to friendship' do
    send_invitation('taofeek@gmail.com', '123456')
    expect(page).to have_content 'Your invitation has been sent!'
  end

  it 'accepts an ivitation' do
    send_invitation('taofeek@gmail.com', '123456')
    click_link('Sign out')
    do_login('teeboy@gmail.com', '123456')
    click_link('Teeboy')
    click_link('accept')
    expect(page).to have_content 'Invitation accepted successfully'
  end

  it 'rejects an invitation' do
    send_invitation('taofeek@gmail.com', '123456')
    click_link('Sign out')
    do_login('teeboy@gmail.com', '123456')
    click_link('Teeboy')
    click_link('reject')
    expect(page).to have_content 'Invitation has been declined'
  end
end
