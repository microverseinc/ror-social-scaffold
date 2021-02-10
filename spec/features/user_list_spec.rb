require 'rails_helper'

RSpec.describe 'UserLists', type: :feature do
  let(:user) { create(:user) }

  before do
    feature_sign_in(user)
    visit users_path
  end

  it 'lists all the users' do
    expect(page).to have_text(user.name)
  end

  it 'shows the users profile path' do
    expect(page).to have_link('See', href: user_path(user))
  end
end
