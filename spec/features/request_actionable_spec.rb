require 'rails_helper'

RSpec.describe 'RequestActionables', type: :feature do
  it 'should send the friend request' do
    user = create(:user)
    create(:user)
    feature_sign_in(user)

    visit users_path
    click_button 'Invite'

    expect(page).to have_text('Invited to friend request')
  end

  it 'should accept the friend request' do
    user = create(:user)
    another_user = create(:user)
    another_user.send_friend_request_to(user)
    feature_sign_in(user)

    visit users_path
    click_button 'Accept'

    expect(page).to have_text('Accepted friend request')
  end

  it 'should be able to reject the friend request' do
    user = create(:user)
    another_user = create(:user)
    another_user.send_friend_request_to(user)
    feature_sign_in(user)

    visit users_path
    click_button 'Reject'

    expect(page).to have_text('Rejected friend request')
  end

  it 'should be able to cancel the friend request' do
    user = create(:user)
    another_user = create(:user)
    another_user.send_friend_request_to(user)
    feature_sign_in(another_user)

    visit users_path
    click_button 'Cancel'

    expect(page).to have_text('Rejected friend request')
  end

  it 'should be able to remove the friend request' do
    user = create(:user)
    another_user = create(:user)
    another_user.send_friend_request_to(user)
    user.accept_friend_request_of(another_user)
    feature_sign_in(user)

    visit users_path
    click_button 'Remove'

    expect(page).to have_text('Rejected friend request')
  end
end
