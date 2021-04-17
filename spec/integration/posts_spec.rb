require 'rails_helper'

RSpec.describe 'Posts >', type: :feature do
  let(:user_a) { User.new(name: 'Mohammed', email: 'mohammed@email.com', password: 'qwerty') }
  let(:user_b) { User.new(name: 'Jesus', email: 'jesus@email.com', password: 'qwerty') }
  let(:post) do
    Post.new(content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,
              sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
  end

  def sign_up(user)
    visit new_user_registration_path
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Sign up'
  end

  feature 'Create Post' do
    scenario 'Create a new post from the timeline' do
      visit new_user_registration_path
      sign_up(user_a)
      visit posts_path
      fill_in 'post_content', with: post.content
      click_on 'Save'

      expect(page).to have_content('Post was successfully created.')
    end
  end
end
