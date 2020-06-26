require 'rails_helper'
def log_in_with(email, password)
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

RSpec.feature 'Requests', type: :feature do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com', password: '123456') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com', password: '123456') }

  scenario 'User has a friend request to accept and accepts it. A symetrical record is created as well' do
    user1.friendships.create(friend_id: user2.id)
    log_in_with(user2.email, user2.password)
    visit requests_path

    requests = user2.friend_requests.map(&:user).paginate(page: 1)

    requests.each do |user|
      expect(page).to have_css('p', text: user.name.to_s)
      expect(page).to have_css('a', text: 'Accept friend request')
    end

    expect(user1.friendships.find_by(friend_id: user2.id).status).to eql(false)
    expect(user2.friendships.find_by(friend_id: user1.id)).to eql(nil)
    click_link('Accept friend request')
    expect(user1.friendships.find_by(friend_id: user2.id).status).to eql(true)
    expect(user2.friendships.find_by(friend_id: user1.id).status).to eql(true)
  end
  scenario 'User sends a freidn request but cant auto accept it' do
    user1.friendships.create(friend_id: user2.id)
    log_in_with(user1.email, user1.password)
    visit requests_path

    requests = user1.friend_requests.map(&:user).paginate(page: 1)

    requests.each do |user|
      expect(page).to have_no_css('p', text: user.name.to_s)
      expect(page).to have_no_css('a', text: 'Accept friend request')
    end

    expect(user1.friendships.find_by(friend_id: user2.id).status).to eql(false)
    expect(user2.friendships.find_by(friend_id: user1.id)).to eql(nil)
  end
end
