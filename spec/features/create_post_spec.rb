require 'rails_helper'

feature 'post creation' do
  before(:example) do
    FactoryBot.create(:user)
    visit 'users/sign_in'
    fill_in 'user_email', with: 'sam@sam.com'
    fill_in 'user_password', with: '123456'
  end

  it 'creates a new post' do
    click_on 'Log in'
    fill_in 'post_content', with: 'Samis post'
    click_button 'commit'
  end
end
