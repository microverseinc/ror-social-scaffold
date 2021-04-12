require 'rails_helper'

RSpec.describe 'Creating comments', type: :feature do
  before :each do
    User.create(name: 'Alexis', email: 'a@mail.com', password: '123456')
    user1 = User.create(name: 'Oscar', email: 'o@mail.com', password: '123456')
    user1.posts.create(content: 'A new post by Oscar.')

    visit user_session_path
    fill_in 'Email', with: 'a@mail.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    visit user_path(user1)
  end
  scenario 'Create a new comment successfully' do
    fill_in 'comment_content', with: "Commenting on Oscar's post."
    click_on 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end

  scenario 'Create a new comment unsuccessfully' do
    click_on 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
end
