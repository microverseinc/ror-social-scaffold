describe 'Create a post', type: :feature do
  before :each do
    @user = User.create(email: 'user@example.com', password: 'password', name: 'user')
    @friend = User.create(email: 'friend@example.com', password: 'friend_password', name: 'friend')
  end
  after :each do
    @user.destroy
    @friend.destroy
  end
  it 'Invite a friend' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/users'
    click_link 'Invite to friendship'
    expect(@user.pending_friends).to include(@friend)
  end
  it 'Confirm a friendship' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/users'
    click_link 'Invite to friendship'
    click_link 'Sign out'
    visit '/users/sign_in'
    fill_in 'Email', with: 'friend@example.com'
    fill_in 'Password', with: 'friend_password'
    click_button 'Log in'
    visit '/users'
    click_link 'Accept'
    expect(@user.friends).to include(@friend)
  end
  it 'Decline a friendship' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/users'
    click_link 'Invite to friendship'
    click_link 'Sign out'
    visit '/users/sign_in'
    fill_in 'Email', with: 'friend@example.com'
    fill_in 'Password', with: 'friend_password'
    click_button 'Log in'
    visit '/users'
    click_link 'Decline'
    expect(@user.friends).not_to include(@friend)
  end
  it 'Remove a friendship' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit '/users'
    click_link 'Invite to friendship'
    click_link 'Sign out'
    visit '/users/sign_in'
    fill_in 'Email', with: 'friend@example.com'
    fill_in 'Password', with: 'friend_password'
    click_button 'Log in'
    visit '/users'
    click_link 'Accept'
    click_link 'Remove Friendship'
    expect(@user.friends).not_to include(@friend)
  end
end
