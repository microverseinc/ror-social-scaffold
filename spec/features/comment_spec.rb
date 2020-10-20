require 'rails_helper'
RSpec.describe 'Comment', type: :feature do
  before(:each) do
    User.create(name: 'Ibe Precious', email: 'i.email@example.com', password: 'secretpass',
                password_confirmation: 'secretpass')
    visit visit new_user_session_path
    fill_in 'user_email', with: 'i.email@example.com'
    fill_in 'user_password', with: 'secretpass'
    find("input[type='submit']").click
  end
  it 'User can make and save comment' do
    fill_in 'post[content]', with: 'This is my post test'
    click_button 'Save'

    fill_in 'comment[content]', with: 'This is my comment test'
    click_button 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end
  it 'User cannot save blank comment' do
    fill_in 'post[content]', with: 'This is my post test'
    click_button 'Save'

    fill_in 'comment[content]', with: ''
    click_button 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
  it 'Comment cannot be more than 200 characters' do
    fill_in 'post[content]', with: 'This is my post test'
    click_button 'Save'

    fill_in 'comment[content]', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                      Phasellus sapien turpis, fringilla non lectus id, mattis
                                      scelerisque lacus. Nunc nec suscipit lectus, id dictum odio.
                                      Integer faucibus lorem eu congue rutrum. Ut sollicitudin, nulla quis
                                      placerat mattis, elit felis tincidunt nunc'
    click_button 'Comment'
    expect(page).to have_content('Content 200 characters in comment is the maximum allowed.')
  end
end
