require 'rails_helper'

RSpec.describe 'Hello world', type: :system do
  before(:all) do
    user1 = User.create(name: 'test2', password: 'testing2', email: 'new_email@email.com')
    user2 = User.create(name: 'test', password: 'testing', email: 'email@email.com')
    Post.create(user_id: user1.id, content: 'rat')
    Post.create(user_id: user2.id, content: 'snake')
  end

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
        expect(page).to have_no_content('rat')
      end

      it 'i can see my own posts' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_content('snake')
      end
    end
  end

  describe 'When one user send you a friend request' do
    before(:all) do
      Friendship.create(requestor_id: User.first.id, requested_id: User.last.id, status: false)
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

      it 'i can see my own posts' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_content('snake')
      end
    end
  end

  describe 'When friendship exists' do
    before(:all) do
      Friendship.first.update(status: true)
      Friendship.create(requestor_id: User.last.id, requested_id: User.first.id, status: true)
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
      it 'i can see post from friends' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_content('rat')
      end

      it 'i can see my own posts' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        expect(page).to have_content('snake')
      end

      it 'i can see my own post that i just create' do
        visit new_user_session_path
        fill_in 'Email', with: 'email@email.com'
        fill_in 'Password', with: 'testing'
        click_on 'Log in'
        click_on 'Timeline'
        fill_in 'post_content', with: 'hawk'
        click_on 'Save'
        expect(page).to have_content('hawk')
      end
    end
  end
end
