require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  login

  scenario 'send a request' do
    visit users_path
    click_button 'Add Friend'

    expect(page).to have_text('You have sent a friend request.')
  end

  scenario 'accept a freind request' do
    visit users_path
    click_button 'Accept'

    expect(page).to have_text('You accepted a friend')
  end

  scenario 'reject a freind request' do
    visit users_path
    click_button 'Reject'

    expect(page).to have_text('You rejected a friend request.')
  end

  scenario 'cancel a freind request' do
    visit users_path

    accept_confirm do
      click_button 'Requested'
    end

    expect(page).to have_text('You rejected a friend request.')
  end
end
