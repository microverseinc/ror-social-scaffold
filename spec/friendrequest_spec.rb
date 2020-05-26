require 'rails_helper'
require 'capybara/rspec'

describe 'Friend request testging', type: :feature do
  before :each do
    a = User.new(name: 'maje', email: 'user@example.com', password: 'password1234')
    a.save
    b = User.new(name: 'deme', email: 'ali@example.com', password: 'password1234')
    b.save
    c = Friendship.new(user_id: 1, friend_id: 2, confirmed: false)
    c.save
    visit '/users/sign_in'
    within('form') do
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password1234'
    end
    click_button 'commit'
  end
  it 'friend request page' do
    visit '/users'
    expect(page).to have_content 'send request'
  end
  it 'send request' do
    visit 'users'
    first(:link, 'send request').click

    expect(page).to have_content 'cancel request'
  end
end
