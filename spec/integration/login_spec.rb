require 'rails_helper'

RSpec.describe 'Log in', type: :feature do
    let(:user) { User.create!(name: 'Mohammad', email: 'jay@gmail.com', password: 'abc123456789', password_confirmation: 'abc123456789' ) }
    let(:friend) { User.create!(name: 'James', email: 'fahad@gmail.com', password: 'abc123456789', password_confirmation: 'abc123456789') }
    let(:post) {Post.create!(user_id:user.id,content: 'This is my content post')}
  
    scenario 'sign in' do
      visit root_path
      click_link 'Sign in'

      # Fil the fields
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_on 'Log in'
      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('Mohammad')
      #create post
      fill_in 'post_content', with: 'This is my content post'
      click_button 'Save'
      expect(page).to have_content('Post was successfully created.')

    end
end