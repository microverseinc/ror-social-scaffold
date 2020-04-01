require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  let!(:user) do
    User.create(
      name: 'amadou',
      email: 'amadou@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  describe 'Post creation' do
    before do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(current_path).to eq root_path
      expect(page).to have_content(user.name.to_s)
      expect(page).to have_content('Signed in successfully')
    end

    it 'create a new post' do
      fill_in 'post_content', with: 'Hello World!'
      click_button 'Publish'
      expect(current_path).to eq posts_path
      expect(page).to have_content('Hello World!')
    end
    it 'return an error if the post content is not provided' do
      click_button 'Publish'
      expect(current_path).to eq posts_path
      expect(page).to have_content("Post could not be saved. Content can't be blank")
    end
  end
end
