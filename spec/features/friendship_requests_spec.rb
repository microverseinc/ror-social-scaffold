require 'rails_helper'

feature 'friendship requests features', type: :feature do
  scenario "an 'Invite Friend' button which sends a friend request" do
    create_user('Abdullah Numan', 'anewman15@hotmail.com', '123456')
    click_on 'Sign out'
    create_user('Neshat Tasnim', 'neshat.tasnim@hotmail.com', 'abcdef')
    visit '/users'
    click_on 'Invite Friend'

    expect(page).to have_content('Friend request sent.')
  end

  scenario "a 'Cancel Invite' button which deletes a friend request" do
    create_user('Abdullah Numan', 'anewman15@hotmail.com', '123456')
    click_on 'Sign out'
    create_user('Neshat Tasnim', 'neshat.tasnim@hotmail.com', 'abcdef')
    visit '/users'
    click_on 'Invite Friend'
    visit '/users'
    click_on 'Cancel Invite'

    expect(current_path).to eq('/friendships')
    expect(page).to have_content('Friend request canceled/rejected/removed')
  end

  scenario "a 'Reject Friend' button which rejects a friendship request" do
    create_user('Abdullah Numan', 'anewman15@hotmail.com', '123456')
    click_on 'Sign out'
    create_user('Neshat Tasnim', 'neshat.tasnim@hotmail.com', 'abcdef')
    visit '/users'
    click_on 'Invite Friend'
    click_on 'Sign out'
    sign_in('anewman15@hotmail.com', '123456')
    visit '/users'
    click_on 'Reject Friend'

    expect(current_path).to eq('/friendships')
    expect(page).to have_content('Friend request canceled/rejected/removed')
  end

  scenario "an 'Accept Friend' button which confirms a friendship" do
    create_user('Abdullah Numan', 'anewman15@hotmail.com', '123456')
    click_on 'Sign out'
    create_user('Neshat Tasnim', 'neshat.tasnim@hotmail.com', 'abcdef')
    visit '/users'
    click_on 'Invite Friend'
    click_on 'Sign out'
    sign_in('anewman15@hotmail.com', '123456')
    visit '/users'
    click_on 'Accept Friend'

    expect(current_path).to eq('/friendships')
    expect(page).to have_content('New friend added successfully!')
  end

  scenario "an 'Remove Friend' button which re moves a friend" do
    create_user('Abdullah Numan', 'anewman15@hotmail.com', '123456')
    click_on 'Sign out'
    create_user('Neshat Tasnim', 'neshat.tasnim@hotmail.com', 'abcdef')
    visit '/users'
    click_on 'Invite Friend'
    click_on 'Sign out'
    sign_in('anewman15@hotmail.com', '123456')
    visit '/users'
    click_on 'Accept Friend'
    visit '/users'
    click_on 'Remove Friend'

    expect(current_path).to eq('/friendships')
    expect(page).to have_content('Friend request canceled/rejected/removed')
  end

  private

  def create_user(name, email, password)
    visit '/users/sign_up'
    fill_in 'user_name', with: name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_on 'Sign up'
  end

  def send_friend_request
    create_user('Abdullah Numan', 'anewman15@hotmail.com', '123456')
    click_on 'Sign out'
    create_user('Neshat Tasnim', 'neshat.tasnim@hotmail.com', 'abcdef')
    visit '/users'
    click_on 'Invite Friend'
  end

  def sign_in(email, password)
    visit 'users/sign_in'
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_on 'Log in'
  end
end
