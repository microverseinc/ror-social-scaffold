require 'rails_helper'

feature 'Posts', type: :feature do
  fixtures :posts, :users

  context 'Create a new post' do
    scenario 'should be successfull' do
      login_as(users(:user1))
      visit 'posts'

      fill_in 'post_content', with: 'First Post'
      click_button 'Save'
      expect(page).to have_content('Post was successfully created.')
      expect(page).to have_content('First Post')
    end

    scenario 'should be successfull' do
      login_as(users(:user1))
      visit 'posts'
      within('form#new_post') do
        fill_in 'post_content', with: ''
      end
      click_button 'Save'
      expect(page).to have_content("Post could not be saved. Content can't be blank")
    end
  end
end
