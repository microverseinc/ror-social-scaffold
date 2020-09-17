require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  login
  scenario 'Like a post' do
    visit posts_path
    click_link 'Like!'
    expect(page).to have_text('You liked a post.')
  end

  scenario 'Dislike a post' do
    visit posts_path
    click_link 'Like!'
    click_link 'Dislike!'
    expect(page).to have_text('You disliked a post.')
  end
end
