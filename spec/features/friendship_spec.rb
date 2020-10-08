require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  login

  scenario 'send a request' do
    visit users_path
    all('input[type="submit"]').first.click
  end

  scenario 'accept a friend request' do
    visit friendships_path
    all('input[type="submit"]').first.click
  end

  scenario 'reject a friend request' do
    visit friendships_path
    click_button 'Reject friendship'
  end

  scenario 'cancel a friend request' do
    visit users_path

    accept_confirm do
      click_link('Delete friendship request')
    end
  end
end
