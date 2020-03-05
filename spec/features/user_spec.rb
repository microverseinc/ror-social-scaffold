require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:user_valid) do
    has_x = { name: 'jay', email: 'jay@gmail.com' }
    has_x[:password] = 'jayjay'
    has_x[:password_confirmation] = 'jayjay'

    has_x
  end

  scenario 'user that are not loggeg in can\'t see other users profile' do
    user = User.create(user_valid)
    visit user_path(user.id)
    expect(page).to_not have_content user.name
  end

  scenario ' user index page should show the list of users' do
    user = User.create(user_valid)
    user2 = User.new(user_valid)
    user2.email = 'elo@emai.com'
    user2.save
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'

    visit users_path
    expect(page).to have_content user2.name
  end

  scenario 'User profile renders properly' do
    user = User.create(user_valid)
    visit user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user_valid[:password]
    click_button 'Log in'
    Post.create(user_id: user.id, content: 'Lorem Impsum')
    visit user_path(user)
    expect(page).to have_content user.name

    expect(page).to have_content user.posts.last.content
  end

  scenario 'User registers succesfully' do
    visit new_user_registration_path
    expect do
      fill_in 'user_name', with: user_valid[:name]
      fill_in 'user_email', with: user_valid[:email]
      fill_in 'user_password', with: user_valid[:password]
      fill_in 'user_password_confirmation', with: user_valid[:password_confirmation]
      click_button 'Sign up'
    end.to change(User, :count).by(1)
    user = User.last
    expect(user.name).to eq(user_valid[:name])
  end
end
