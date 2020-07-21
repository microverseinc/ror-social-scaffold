require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  context 'Users exist' do
    let(:quote) { Faker::Movies::StarWars.quote }
    let(:users_list) { create_list(:random_user_list, 10) }
    let(:friendship_list) { create_list(:friendship_list, 5) }
    let(:posts_list) { create_list(:random_post_list, 10) }

    it 'should be able to create a post' do
      user = create(:random_user)
      login_user(user)
      visit 'posts'
      within('form') do
        fill_in 'Add New Post', with: quote
      end
      click_button 'Save'
      expect(page).to have_content('Post was successfully created.')
    end

    it 'should show all posts created by user and her friends' do
      users_list
      friendship_list
      posts_list
      user = users_list.first
      login_user(user)
      visit root_path
      expect(page).to have_css('.post', count: 6)
    end
  end
end
