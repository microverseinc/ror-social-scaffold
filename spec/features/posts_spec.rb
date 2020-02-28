require 'rails_helper'

RSpec.feature 'Post' do
  include Integration
  before(:each) do
    create_initial_conditions
    create_posts
  end

  it 'displays all the created posts' do
    expect(find_all('li.post').count).to be(2)
  end

  it "doesn't let you create a post without content" do
    click_button 'Save'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
  end

  it "doesn't let you create a post with too long content" do
    fill_in 'post_content', with: 'a' * 1001
    click_button 'Save'
    expect(page).to have_content('Post could not be saved. Content 1000 characters in post is the maximum allowed.')
  end
end
