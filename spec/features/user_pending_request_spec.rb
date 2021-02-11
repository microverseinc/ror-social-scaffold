require 'rails_helper'

RSpec.describe 'UserPendingRequests', type: :feature do
  it 'should list all the users that have sent the request' do
    user = create(:user)
    another_user = create(:user, name: 'Mamakane')
    another_user.send_friend_request_to(user)
    feature_sign_in(user)
    visit user_path(user)

    expect(page).to have_text(another_user.name)
  end

  it 'should not see the request that has been accepted' do
    user = create(:user)
    another_user = create(:user, name: 'Mamakane')
    another_user.send_friend_request_to(user)
    user.accept_friend_request_of(another_user)
    feature_sign_in(user)
    visit user_path(user)

    expect(page).not_to have_text(another_user.name)
  end
end
