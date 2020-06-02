require 'rails_helper'

feature 'Adding and Removing Freinds' do
  before(:example) do
    FactoryBot.create(:user)
    FactoryBot.create(:user, email: 'apple2@gmail.com', name: 'User2')
    visit '/users/sign_in'
    fill_in 'user_email', with: 'apple@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    visit '/users'
  end

  scenario 'shows all users in users index page' do
    expect(page).to have_content 'Name:'
  end

  scenario 'Indicates if user page visited belongs to logged in user' do
    click_on 'User1'
    expect(page).to have_content 'Your Profile'
  end

  scenario 'Gives option to add friend if user is not a freind' do
    click_on 'User2'
    expect(page).to have_content 'Add Friend'
  end

  scenario 'Indicates that request is sent if add friend is pressed' do
    click_on 'User2'
    click_on 'Add Friend'
    click_on 'User2'
    expect(page).to have_content 'Already sent request'
  end

  scenario 'Can view confirmation, confirm freind and remove friend' do
    click_on 'User2'
    click_on 'Add Friend'
    click_on 'Sign out'
    visit '/users/sign_in'
    fill_in 'user_email', with: 'apple2@gmail.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    visit '/users'
    click_on 'User1'
    expect(page).to have_content 'Confirm'
    click_on 'Confirm'
    click_on 'User1'
    expect(page).to have_content 'Remove Friend'
    click_on 'Remove Friend'
    click_on 'User1'
    expect(page).to have_content 'Add Friend'
  end
end
