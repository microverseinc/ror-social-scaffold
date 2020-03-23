require 'rails_helper'

RSpec.feature 'TimelineFeatures', type: :feature do
  context 'login and get to timeline automatically' do
    before(:each) do
      @user = User.create(name: 'User1', email: 'user1@email.com', password: 'password')

      visit root_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
    describe 'loads navbar' do
      loads_navbar
    end
    describe 'loads form to add new post' do
      it 'has a box to type the post' do expect(page).to have_field 'post_content' end
      it 'has a button to commit the post' do expect(page).to have_button 'Save' end
      it 'has a list of recent posts' do expect(page).to have_selector 'ul.posts' end
    end
    describe 'shows post after creating one' do
      it 'has 0 posts before creating one' do expect(page).to have_selector 'li.post', count: 0 end
      it 'has 1 posts after creating one' do
        fill_in 'post_content', with: 'My first post'
        click_button 'Save'
        expect(page).to have_selector 'li.post', count: 1
      end
    end
  end
end
