require 'rails_helper'
require 'capybara/rspec'
describe 'Post controller and view spec', type: :feature do
  before :each do
    a = User.new(name: 'gajksj', email: 'user@example.com', password: 'password1234')
    a.save
    b = User.new(name: 'gfdgsj', email: 'ali@example.com', password: 'password1234')
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
  it 'post creation' do
    visit '/posts'
    within('form') do
      fill_in 'post[content]', with: 'blah blah blah'
    end
    click_button 'commit'
    expect(page).to have_content 'blah blah blah'
  end
end
