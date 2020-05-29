require 'rails_helper'

RSpec.describe 'Creating friendship invitations', type: :feature do
  before :each do
    user1 = User.create(name: 'Oscar', email: 'o@mail.com', password: '123456')
    user2 = User.create(name: 'Alexis', email: 'a@mail.com', password: '123456')
    user3 = User.create(name: 'Mememan', email: 'm@mail.com', password: '123456')
    user4 = User.create(name: 'Ivan', email: 'i@mail.com', password: '123456')
    user1.posts.create(content: 'A new post by Oscar.')
    user3.posts.create(content: 'A new post by Mememan.')
    user4.posts.create(content: 'A new post by Ivan.')
    f1 = Friendship.create(requesting_friend: user4, requested_friend: user2, status: false) # request sent
    f1.update(status: true) # request accepted
    f2 = Friendship.create(requesting_friend: user2, requested_friend: user3, status: false) # request sent
    f2.update(status: true) # request accepted

    visit user_session_path
    fill_in 'Email', with: 'a@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end

  scenario 'Send a friendship invitation ' do
    click_on 'All users'
    click_on 'Invite'
    expect(page).to have_content('Friendship was successfully created.')
  end

  scenario 'Decline a friendship invitation ' do
    click_on 'All users'
    click_on 'Invite'
    click_on 'Sign out'
    fill_in 'Email', with: 'o@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Decline'
    expect(page).to have_content('Friendship was successfully destroyed.')
  end

  scenario 'Accept a friendship invitation ' do
    click_on 'All users'
    click_on 'Invite'
    click_on 'Sign out'
    fill_in 'Email', with: 'o@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Accept'
    expect(page).to have_content('Friendship was successfully updated.')
  end

  scenario 'User can see posts from his requested friends' do
    expect(page).to have_content('A new post by Mememan.')
  end
  scenario 'User can see posts from his requesting friends' do
    expect(page).to have_content('A new post by Ivan.')
  end

  scenario " User would not be able to see a post of a user who's not his friend " do
    expect(page).to_not have_content('A new post by Oscar.')
  end
end
