require 'rails_helper'
require 'capybara/rspec'
describe 'Testing post controller and views', type: :feature do
  before :each do
    a = User.new(name: 'gajksj', email: 'user@example.com', password: 'password1234')
    a.save
    b = User.new(name: 'gfdgsj', email: 'ali@example.com', password: 'password1234')
    b.save
    c = Friendship.new(user_id: 1, friend_id: 2, confirmed: false)
    c.save
    visit '/users/sign_in'
    within('main') do
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password1234'
    end
    click_button 'commit'
  end
  it 'post creation' do
    visit '/posts'
    within('main') do
      fill_in 'post[content]', with: 'Some random contents'
    end
    click_button 'Save'
    expect(page).to have_content 'Some random contents'
  end
end