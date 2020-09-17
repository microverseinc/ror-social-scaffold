require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  login
  scenario 'Create A New Post' do
    visit posts_path
    fill_in 'post_content', with: 'Stay Safe, No fun in death.'
    click_button 'Save'

    expect(page).to have_text('Post was successfully created.')
  end
end
