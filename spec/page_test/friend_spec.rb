require 'rails_helper'

RSpec.describe 'Hello world', type: :system do
  before(:all) do
    User.create(name: 'test2', password: 'testing2', email: 'new_email@email.com')
    User.create(name: 'test', password: 'testing', email: 'email@email.com')
    Post.create(user_id: 1, content: 'rat')
    Post.create(user_id: 2, content: 'snake')
  end

  let(:user) { User.find(2) }
  let(:friend_user) { User.find(1) }

  describe 'When friendship does not exists' do
    context 'All users page' do
      it 'i can see the send request button' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'All users'
        expect(page).to have_link('Request Friendship')
      end

      it 'i can send a friend request' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'All users'
        click_on 'Request Friendship'
        expect(page).to have_content('Waiting For Response')
      end
    end

    context 'Timeline page' do
      it 'i can\'t see post from non-friend users' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_no_content('Lorem')
      end
    end
  end

  describe 'When one user send you a friend request' do
    before(:all) do
      Friendship.create(requestor_id: 1, requested_id: 2, status: false)
    end

    context 'all users page' do
      it 'i can see buttons to accept or reject friendship' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'All users'
        expect(page).to have_link('Accept request')
        expect(page).to have_link('Reject request')
      end

      it 'i accept friend request' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'All users'
        click_on 'Accept request'
        expect(page).to have_content('You Are Friends')
      end

      it 'i reject friend request' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'All users'
        click_on 'Reject request'
        expect(page).to have_link('Request Friendship')
      end
    end

    context 'Timeline page' do
      it 'i can\'t see post from non-friend users' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_no_content('rat')
      end
    end
  end

  describe 'When friendship exists' do
    before(:all) do
      Friendship.create(requestor_id: 1, requested_id: 2, status: true)
      Friendship.create(requestor_id: 2, requested_id: 1, status: true)
    end

    context 'All users page' do
      it 'Users are friends' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'All users'
        expect(page).to have_content('You Are Friends')
      end
    end

    context 'Timeline' do
      it 'i can see post from friend users' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_content('rat')
      end
    end
  end
end
