require 'rails_helper'

RSpec.describe Friendshipp, type: :feature do
  def log_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end

  context 'sending a friend request' do
    it 'sends a friend request' do
      sender = User.create(name: 'Sharon', email: 'piexioeexa@hh.com', password: 'i8juejj41A')
      log_in(sender)
      visit users_path
    end
  end

  context 'approving a friend request' do
    it 'accepts a friend request' do
      user = User.create(name: 'Hope', email: 'jjdjj@uu.com', password: '9djsHHu')
      user2 = User.create(name: 'James', email: 'jjfdfddjj@uu.com', password: '9djsfffHHu')
      user2.friendshipps.create(friend_id: user.id, confirmed: false)
      log_in(user)
      visit users_path
      expect(page).to_not have_content 'No Friend Requests Yet'
    end
  end

  context 'rejecting a friend requests' do
    it 'rejects a friend request' do
      user = User.create(name: 'Hopefu', email: 'jjdjsdj@uu.com', password: '9dj555sHHu')
      user2 = User.create(name: 'Jameddsds', email: 'jjfdsdsddfddjj@uu.com', password: '9dj555sfffHHu')
      user2.friendshipps.create(friend_id: user.id, confirmed: false)
      log_in(user)
      visit users_path
      expect(user.friend?(user2)).to eql(false)
    end
  end
end
