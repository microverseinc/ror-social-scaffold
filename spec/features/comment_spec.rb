require 'rails_helper'
RSpec.describe 'Comment', type: :feature do
  before(:each) do
    User.create(name: 'Alex', email: 'alex@gmail.com', password: '123456',
                password_confirmation: '123456')
    visit new_user_session_path
    fill_in 'user_email', with: 'alex@gmail.com'
    fill_in 'user_password', with: '123456'
    find("input[type='submit']").click
  end
  it 'User can create and save a comment' do
    fill_in 'post[content]', with: 'This is the test post for comment model'
    click_button 'Save'

    fill_in 'comment[content]', with: 'This is the test post for comment model'
    click_button 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end
  it 'User cannot save a blank or empty comment' do
    fill_in 'post[content]', with: 'This is the test post for comment model'
    click_button 'Save'

    fill_in 'comment[content]', with: ''
    click_button 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
  it 'Comment cannot be more than 200 characters' do
    fill_in 'post[content]', with: 'This is the test post for comment model'
    click_button 'Save'

    fill_in 'comment[content]', with: 'Lorem ipsum dolor sit amet,                              consectetur adipiscing
                                       elit.
                                       Phasellus sapien turpis, fringilla  non lectus id, mattis
                                       scelerisque lacus. Nunc nec suscipit lectus, id dictum odio.
                                       Integer faucibus lorem eu congue rutrum. Ut sollicitudin, nulla quis
                                       placerat mattis, elit felis tincidunt nunc'
    click_button 'Comment'
    expect(page).to have_content('Content 200 characters in comment is the maximum allowed.')
  end
end
