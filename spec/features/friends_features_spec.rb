require 'rails_helper'

RSpec.feature 'FriendsFeatures', type: :feature do
  context 'login and go to frienships' do
    before(:each) do
      setup_users
      visit_friendships
    end
    describe 'loads navbar' do
      loads_navbar
    end
    describe 'loads friends' do
      it 'loads the friendships table' do expect(page).to have_selector '.friendships' end
      it 'loads the friends' do expect(page).to have_selector 'h1', text: 'User1 has 0 Friends' end
      it 'loads the Pending request' do expect(page).to have_selector 'h1', text: 'User1 has 1 Pending request' end
      it 'loads the Friend requests' do expect(page).to have_selector 'h1', text: 'User1 has 1 Friend request' end
    end
    describe 'user can view and accept friendship' do
      before(:each) do
        click_button 'see friend request'
      end
      it 'shows invitor and invited' do expect(page).to have_selector 'li.user', count: 2 end
      it 'shows button to accept' do expect(page).to have_link 'accept friendship' end
      it 'can accept invitation' do
        click_on 'accept friendship'
        expect(page).to have_selector 'h1', text: 'User1 has 1 Friend'
      end
      it 'can reject invitation' do
        click_on 'reject friendship'
        expect(page).to have_selector 'h1', text: 'User1 has 0 Friend request'
      end
    end
  end
end

def setup_users
  @user = User.create(name: 'User1', email: 'user1@email.com', password: 'password')
  @user2 = User.create(name: 'User2', email: 'user2@email.com', password: 'password')
  @user3 = User.create(name: 'User3', email: 'user3@email.com', password: 'password')
  @user4 = User.create(name: 'User4', email: 'user4@email.com', password: 'password')
  Friendship.create(user_id: @user2.id, friend_id: @user.id)
  Friendship.create(user_id: @user.id, friend_id: @user3.id)
end

def visit_friendships
  visit root_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
  visit user_friendships_path(@user)
end
