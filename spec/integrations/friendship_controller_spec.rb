require 'rails_helper'

RSpec.describe 'friendship controller', type: :feature do
  let(:test_user) do
    User.new(name: 'test_user', email: 'carl@carl',
             password: 'password', password_confirmation: 'password')
  end
  let(:test_user_2) do
    User.new(name: 'test_user_2', email: 'carl@carl',
             password: 'password', password_confirmation: 'password')
  end

  let(:friendship) { Friendship.new(user_id: test_user_2.id, friend_id: test_user.id, confirmed: false) }
  let(:friendship_2) { Friendship.new(user_id: test_user.id, friend_id: test_user_2.id, confirmed: true) }

  def store_in_database
    test_user.save
    test_user_2.save
  end

  def save_friendships
    friendship.save
  end

  def log_in
    visit users_path
    fill_in 'Email', with: test_user.email
    fill_in 'Password', with: test_user.password
    click_button 'Log in'
  end
end