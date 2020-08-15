require 'rails_helper'

feature 'Friendship', type: :feature do
  before(:each) do
    user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    visit new_user_session_path
    within('form') do
      fill_in 'user_email', with: user1.email
      fill_in 'user_password', with: user1.password
    end
    click_on 'Log in'
  end

  scenario 'Add friend' do
    visit users_path
    click_on 'Add Friend'
    expect(page).to have_content('Friend request sent')
  end

  scenario 'Accept friend' do
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    within('form') do
      fill_in 'user_email', with: @user2.email
      fill_in 'user_password', with: @user2.password
    end
    click_on 'Log in'
    visit users_path
    click_on 'Accept'
    expect(page).to have_content('Friend request accepted')
  end

  scenario 'Decline friend' do
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    within('form') do
      fill_in 'user_email', with: @user2.email
      fill_in 'user_password', with: @user2.password
    end
    click_on 'Log in'
    visit users_path
    click_on 'Decline'
    expect(page).to have_content('Friend request denied')
  end

  scenario 'unfriend friend' do
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    within('form') do
      fill_in 'user_email', with: @user2.email
      fill_in 'user_password', with: @user2.password
    end
    click_on 'Log in'
    visit users_path
    click_on 'Accept'
    click_on 'Unfriend'
    expect(page).to have_content('Add Friend')
  end
end
