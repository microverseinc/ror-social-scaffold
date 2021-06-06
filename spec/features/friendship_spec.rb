require 'rails_helper'

describe 'Friendship Invitation', type: :feature do
  before :each do
    User.create(email: 'user999@gmail.com', password: '123456', name: 'User999')
    User.create(email: 'friend999@gmail.com', password: '123456', name: 'Friend999')
    visit '/users/sign_in'
    fill_in 'Email', with: 'user999@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'Gets all Members page' do
    visit users_path
    expect(page).to have_text('Name:')
    expect(page).to have_link('See Profile')
  end

  it 'Invitation to Friendship' do
    visit users_path
    expect(page).to have_link('See Profile')
    first('.frienship_button').click
    expect(page).to have_content('Friend Invite Sent.')
  end
end
