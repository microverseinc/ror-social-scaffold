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
    page.has_button?('Invite to friendship')
  end

  scenario 'users have option to invite to friendship and can cancel invite' do
    visit user_path(users(:John))
    count_before = Friendship.count
    click_button('Invite to friendship')
    expect(Friendship.count).to eq(count_before + 1)
    click_button('Cancel invitation')
    expect(Friendship.count).to eq(count_before)
  end
end
