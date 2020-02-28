require 'rails_helper'

RSpec.feature 'Like' do
  include Integration
  before(:each) do
    create_initial_conditions
    create_posts
  end

  it "lets you like a post you haven't liked before" do
    expect(find_all('li.post').count).to be(2)
    expect(page).not_to have_content('Dislike!')
    first(:link, 'Like!').click
    expect(page).to have_content('You liked a post.')
  end

  it 'lets you disllike a post you have liked before' do
    expect(find_all('li.post').count).to be(2)
    expect(page).not_to have_content('Dislike!')
    first(:link, 'Like!').click
    expect(page).to have_content('You liked a post.')
    expect(page).to have_content('Dislike!')
    first(:link, 'Dislike!').click
    expect(page).to have_content('You disliked a post.')
    expect(page).not_to have_content('Dislike!')
  end
end
