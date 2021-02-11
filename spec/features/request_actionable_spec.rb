require 'rails_helper'

RSpec.describe 'RequestActionables', type: :feature do
  it 'should accept the friend request' do
    user = create(:user)
    another_user = create(:user)
    another_user.send_friend_request_to(user)
    feature_sign_in(user)

    visit users_path
    click_button 'Accept'

    expect(page).to have_text('Accepted friend request')
  end
end
