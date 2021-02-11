require 'rails_helper'

RSpec.describe 'SignOuts', type: :feature do
  it 'should redirect to sign in page after signing out' do
    feature_sign_in
    visit root_path
    within '.nav' do
      click_link 'Sign out'
    end

    expect(page).to have_current_path(new_user_session_path)
  end
end
