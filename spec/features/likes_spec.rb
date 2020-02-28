require 'rails_helper'

def create_initial_conditions
  visit new_user_registration_path
  within('form') do
    fill_in 'Name', with: 'john'
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
  end
  click_button 'Sign up'
  click_link 'Timeline'
end

def create_posts
  fill_in 'post_content', with: 'First Post'
  click_button 'Save'
  fill_in 'post_content', with: 'Second Post'
  click_button 'Save'
end

RSpec.feature 'Like' do
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
