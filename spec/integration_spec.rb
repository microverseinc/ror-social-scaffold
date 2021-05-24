require 'rails_helper'
require './spec/support/helpers'

feature 'Friendship integration testing by requests sent and accepted' do
  fixtures :users
  fixtures :friendships
  background do
    sam = User.new(name: 'samrood', email: 'user@example.com', password: 'password')
    sign_up_with(sam)
  end

  scenario 'home page has new post input tag' do
    expect(page).to have_selector('#post_content')
  end

  scenario 'users page has users' do
    visit users_path
    expect(page).to have_selector('.user-name')
    expect(page).to have_selector('.users-list')
    expect(page).to have_selector('.user')
  end
  
  scenario 'users have invite to friendship button' do
    visit users_path
    expect(page).to have_selector('.user-name')
    expect(page).to have_selector("input[value='Invite to friendship']")
    
  end
end
