require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  before :each do
    @user = User.create(name: 'User', email: 'user@mail.com', password: '1234567')
    @user = User.create(name: 'Tony', email: 'tony@mail.com', password: '1234567')
  end

  it 'Should see list of users to add as frineds' do
    visit root_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: '1234567'
    click_button 'Log in'
    click_on 'Find Friends'
    expect(page).to have_content('Tony')
  end

  it 'Should be able to add a new friend' do
    visit root_path
    fill_in 'user_email', with: 'user@mail.com'
    fill_in 'user_password', with: '1234567'
    click_button 'Log in'
    click_on 'Find Friends'
    click_on 'Tony'
    expect(page).to have_content('Invite to friendship')
  end
end
