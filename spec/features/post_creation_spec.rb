require 'rails_helper'

RSpec.describe 'PostCreations', type: :feature do
  it 'redirects to posts path after creating the post' do
    user = create(:user)
    feature_sign_in(user)
    visit root_path
    fill_in 'Content', with: 'First post'
    click_button 'Save'

    expect(page).to have_current_path(posts_path)
  end

  it 'shows error if fields are not valid' do
    user = create(:user)
    feature_sign_in(user)
    visit root_path
    fill_in 'Content', with: ''
    click_button 'Save'

    expect(page).to have_text('Post could not be saved')
  end
end
