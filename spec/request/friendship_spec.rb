require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before do
    @user = User.create(name: 'Tash', email: 't@mail.com', password: 'foobar')
    @user2 = User.create(name: 'Nyan', email: 'n@mail.com', password: '123456')
    @user3 = User.create(name: 'User', email: 'u@mail.com', password: '123456')
    @friendship = Friendship.create(user_id: @user2.id, friend_id: @user.id, status: false)
    @friendship2 = Friendship.create(user_id: @user3.id, friend_id: @user.id, status: false)
  end

  scenario 'click friend request invite send' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(find('.notice')).to have_content('Signed in successfully.')
    visit users_path
    expect(find('.users-section')).to have_content('Send Friend Request >>')
    assert_selector 'ul.users-list' do
      assert_selector '.friend-request'
      click_link('Send Friend Request >>', match: :first)
    end
    expect(find('.notice')).to have_content('Send your friend request successfully')
  end

  scenario 'accept friend request' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(find('.notice')).to have_content('Signed in successfully.')
    visit requests_path
    expect(find('h1').text).to have_content('Requests List')
    assert_selector 'ul' do
      assert_selector 'li'
      find_link('Accept', match: :first).visible?
      click_link('Accept', match: :first)
    end
    expect(find('.notice')).to have_content('You accepted request')
  end

  scenario 'cancel friend request' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(find('.notice')).to have_content('Signed in successfully.')
    visit requests_path
    expect(find('h1').text).to have_content('Requests List')
    assert_selector 'ul' do
      assert_selector 'li'
      find_link('Decline', match: :first).visible?
      click_link('Decline', match: :first)
    end
    expect(find('.notice')).to have_content('You decline request')
  end
end
