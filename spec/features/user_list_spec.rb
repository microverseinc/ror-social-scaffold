require 'rails_helper'

RSpec.describe 'UserLists', type: :feature do
  it 'lists all the users' do
    user = create(:user)
    feature_sign_in(user)
    visit users_path

    expect(page).to have_text(user.name)
  end

  it 'shows the users profile path' do
    user = create(:user)
    feature_sign_in(user)
    visit users_path

    expect(page).to have_link('See', href: user_path(user))
  end
end
