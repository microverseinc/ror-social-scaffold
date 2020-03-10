require 'spec_helper'
require 'rails_helper'

RSpec.describe 'friendship controller', type: :feature do
  let(:test_user) do
    User.new(name: 'test_user', email: 'test@user.com',
             password: 'secret', password_confirmation: 'secret')
  end
  let(:test_user_2) do
    User.new(name: 'test_user_2', email: 'test2@user.com',
             password: 'secret', password_confirmation: 'secret')
  end

  let(:friendship) { Friendship.new(user_id: test_user_2.id, friend_id: test_user.id, confirmed: false) }
  let(:friendship_2) { Friendship.new(user_id: test_user.id, friend_id: test_user_2.id, confirmed: false)}

  def store_in_database
    test_user.save
    test_user_2.save
  end

  def save_friendships
    friendship.save
    friendship_2.save
  end

  def log_in
    visit users_path
    fill_in 'Email', with: test_user.email
    fill_in 'Password', with: test_user.password
    click_button 'Log in'
  end

  scenario 'adding a friend' do
    store_in_database
    log_in
    click_link("add-user-#{test_user_2.id}")
    expect(page).to have_selector "span#waiting-user-#{test_user_2.id}"
  end

  scenario 'reject a friend' do
    store_in_database
    save_friendships
    log_in
    click_link("decline-user-#{test_user_2.id}")
    expect(page).to have_selector "a#add-user-#{test_user_2.id}"
  end

  scenario 'accept a friend' do
    store_in_database
    save_friendships
    log_in
    click_link("accept-user-#{test_user_2.id}")
    expect(page).to have_selector "a#unfriend-user-#{test_user_2.id}"
  end

  scenario 'unfriend a friend' do
    store_in_database
    friendship.confirmed = true
    friendship_2.confirmed = true
    save_friendships
    log_in
    click_link("unfriend-user-#{test_user_2.id}")
    expect(page).to have_selector "a#add-user-#{test_user_2.id}"
  end
end
