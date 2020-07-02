require 'rails_helper'
def log_in_with(email, password)
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

RSpec.feature 'Pending', type: :feature do
  let!(:user1) { User.create(name: 'test1', email: 'test1@email.com', password: '123456') }
  let!(:user2) { User.create(name: 'test2', email: 'test2@email.com', password: '123456') }

  scenario 'User has sent a friend request to an user' do
    user1.friendships.create(friend_id: user2.id)
    log_in_with(user1.email, user1.password)
    visit pending_path

    pending = user1.pending_friends.map(&:friend).paginate(page: 1)

    pending.each do |p|
      expect(page).to have_css('p', text: p.name.to_s)
      expect(user1.friendships.find_by(friend_id: p.id).status).to eql(false)
    end
  end
end
