require 'rails_helper'

RSpec.describe 'users/user_actionable' do
  it 'displays the invite button if user has not sent friend request' do
    user = create(:user)
    current_user = create(:user)

    render partial: 'users/user_actionable', locals: { user: user, current_user: current_user }

    expect(rendered).to have_button('Invite', count: 1)
    expect(rendered).not_to have_button('Cancel', count: 1)
  end

  it 'displays the cancel request button if user has sent friend request' do
    user = create(:user)
    current_user = create(:user)
    current_user.send_friend_request_to(user)

    render partial: 'users/user_actionable', locals: { user: user, current_user: current_user }

    expect(rendered).to have_button('Cancel', count: 1)
    expect(rendered).not_to have_button('Invite', count: 1)
  end

  it 'displays the remove friend is the user is a friend' do
    user = create(:user)
    current_user = create(:user)
    current_user.send_friend_request_to(user)
    user.accept_friend_request_of(current_user)

    render partial: 'users/user_actionable', locals: { user: user, current_user: current_user }

    expect(rendered).not_to have_button('Cancel', count: 1)
    expect(rendered).not_to have_button('Invite', count: 1)
    expect(rendered).to have_button('Remove', count: 1)
  end

  it 'displays the accept button' do
    user = create(:user)
    current_user = create(:user)
    user.send_friend_request_to(current_user)

    render partial: 'users/user_actionable', locals: { user: user, current_user: current_user }

    expect(rendered).not_to have_button('Cancel', count: 1)
    expect(rendered).not_to have_button('Invite', count: 1)
    expect(rendered).not_to have_button('Remove', count: 1)
    expect(rendered).to have_button('Accept', count: 1)
    expect(rendered).to have_button('Reject', count: 1)
  end
end
