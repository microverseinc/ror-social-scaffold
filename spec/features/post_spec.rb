require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  before :each do
    @user = User.create(name: 'Alex', email: 'alex@mail.com', password: '123456')
  end

  it 'creates a post' do
    visit user_session_path
    fill_in 'user[email]', with: 'alex@mail.com'
    fill_in 'user[password]', with: '123456'
    click_button 'Log in'
    expect(page).to have_content('Signed in successfully.')
    fill_in 'post[content]', with: 'Alex\'s first post on stay in touch.'
    click_button 'Save'
    expect(page).to have_content('Post was successfully created.')
    expect(page).to have_content('Recent posts')
    expect(page).to have_content('Alex')
    expect(page).to have_content('Alex\'s first post on stay in touch.')
  end
end
