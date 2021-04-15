require 'rails_helper'

RSpec.describe 'User Authentication', type: :system do
  describe 'root page' do
    it 'allows user to create new account' do
      visit root_path
      click_link "Sign up"
      fill_in "Name", with: 'Betty Blue'
      fill_in "Email", with: 'betty_blue@email.com'
      fill_in "Password", with: 'abc123'
      fill_in "Password confirmation", with: 'abc123'
      click_button "Sign up"
      expect(page).to have_content('BETTY BLUE')
    end

    it 'allows user to sign in and sign out' do
      visit root_path
      fill_in "Email", with: 'betty_blue@email.com'
      fill_in "Password", with: 'abc123'
      click_button "Log in"
      expect(page).to have_content('BETTY BLUE')
      click_link "Sign out"
      expect(page).to have_content('Sign in')
    end
  end
end

RSpec.describe 'Friendship Features', type: :system do
  it 'allows users to see friendship requests and to accept or reject them' do
    visit root_path
    click_link "Sign up"
    fill_in "Name", with: 'John Smith'
    fill_in "Email", with: 'john.smith@email.com'
    fill_in "Password", with: 'abc123'
    fill_in "Password confirmation", with: 'abc123'
    click_button "Sign up"
    click_link "Sign out"
    fill_in "Email", with: 'betty_blue@email.com'
    fill_in "Password", with: 'abc123'
    click_button "Log in"
    click_link "All users"
    click_link "John Smith"
    click_button "Invite to friendship"
    click_link "Sign out"
    fill_in "Email", with: 'john.smith@email.com'
    fill_in "Password", with: 'abc123'
    click_button "Log in"
    click_link "Friendship Requests"
    expect(page).to have_content('From: Betty Blue')
    expect(page).to have_button('Accept Friendship')
    expect(page).to have_button('Reject Friendship')
    click_button "Accept Friendship"
    expect(page).to have_content('You have succesfully accepted this request.')
  end
end

RSpec.describe 'Post Features', type: :system do
  it 'allows user to create a new post' do
    visit root_path
    fill_in "Email", with: 'john.smith@email.com'
    fill_in "Password", with: 'abc123'
    click_button "Log in"
    fill_in "Content", with: 'Hi! This is John'
    click_button "Save"
    expect(page).to have_content('Hi! This is John')
  end

  it 'shows logged user and friends\' posts' do
    visit root_path
    fill_in "Email", with: 'betty_blue@email.com'
    fill_in "Password", with: 'abc123'
    click_button "Log in"
    fill_in "Content", with: 'Hi! This is Betty'
    click_button "Save"
    expect(page).to have_content('Hi! This is Betty')
    expect(page).to have_content('Hi! This is John')
  end

  it 'doesn\'t show posts from users that are not friends' do
    visit root_path
    click_link "Sign up"
    fill_in "Name", with: 'Fred Flintstone'
    fill_in "Email", with: 'fred_flinstone@email.com'
    fill_in "Password", with: 'abc123'
    fill_in "Password confirmation", with: 'abc123'
    click_button "Sign up"
    fill_in "Content", with: 'Hi! This is Fred'
    click_button "Save"
    click_link "Sign out"
    fill_in "Email", with: 'betty_blue@email.com'
    fill_in "Password", with: 'abc123'
    click_button "Log in"
    expect(page).not_to have_content('Hi! This is Fred')
  end
end
