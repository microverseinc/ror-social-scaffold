require 'rails_helper'

RSpec.describe 'Creating posts', type: :feature do
  before :each do
    User.create(name: 'Oscar', email: 'a@mail.com', password: '123456')
    visit user_session_path
    fill_in 'Email', with: 'a@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'
  end
  scenario 'Fails to create a new post' do
    click_on 'Save'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
  end
  scenario 'Creates new post successfully' do
    fill_in 'post_content', with: 'My content.'
    click_on 'Save'
    expect(page).to have_content('Post was successfully created.')
  end
end
