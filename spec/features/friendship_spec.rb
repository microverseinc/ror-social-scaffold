require 'rails_helper'

RSpec.describe 'Creating friendship invitations', type: :feature do
  before :each do
    user1 = User.create(name: 'Yusif', email: 'yusif.badmus@mail.com', password: 'BB.Inc_3')
    user2 = User.create(name: 'Ella', email: 'ella.myers@gmail.com', password: 'BB.Inc_3')
    user3 = User.create(name: 'Blaise', email: 'blaise.pascal@gmail.com', password: 'BB.Inc_3')
    user4 = User.create(name: 'Tunde', email: 'tunde.badmus@mail.com', password: 'BB.Inc_3')
    user1.posts.create(content: 'A new post by Yusif.')
    user3.posts.create(content: 'A new post by Ella.')
    user4.posts.create(content: 'A new post by Blaise.')
    f1 = Friendship.create(requesting_friend: user4, requested_friend: user2, confirmed: false) # request sent
    f1.update(confirmed: true) # request accepted
    f2 = Friendship.create(requesting_friend: user2, requested_friend: user3, confirmed: false) # request sent
    f2.update(confirmed: true) # request accepted

    visit user_session_path
    fill_in 'Email', with: 'yusif.badmus@gmail.com'
    fill_in 'Password', with: 'BB.Inc_3'
    click_on 'Log in'
  end

  scenario 'Send a friendship invitation ' do
    click_on 'All users'
    click_on 'Invite to friendship'
    expect(page).to have_content('Friendship request successfully sent.')
  end

  scenario 'Decline a friendship invitation ' do
    click_on 'All users'
    click_on 'Invite to friendship'
    click_on 'Sign out'
    fill_in 'Email', with: 'yusif.badmus@gmail.com'
    fill_in 'Password', with: 'BB.Inc_3'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Decline'
    expect(page).to have_content('Friendship request declined.')
  end

  scenario 'Accept a friendship invitation ' do
    click_on 'All users'
    click_on 'Invite to friendship'
    click_on 'Sign out'
    fill_in 'Email', with: 'yusif.badmus@gmail.com'
    fill_in 'Password', with: 'BB.Inc_3'
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
