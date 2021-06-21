require 'rails_helper'

describe 'User signs up', type: :system do
  let(:email) { 'john@doe' }
  let(:password) { '000000' }
  let(:password_confirmation) { '000000' }

  it 'signs up user with valid data' do
    visit new_user_registration_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
    click_button 'Sign up'

    expect(page).to have_text 'Welcome! You have signed up successfully.'
    expect(page).to have_current_path root_path
  end

  it "doesn't sign up user if email already exists" do
    visit new_user_registration_path
    @user = User.create(name: 'Jane Doe', email: 'jane@doe', password: '111111', password_confirmation: '111111')

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
    click_button 'Sign up'
    expect(page).to have_text 'Email has already been taken'
  end

  it "doesn't sign up user if email is not valid" do
    visit new_user_registration_path
    fill_in 'Email', with: 'ImNotAnEmail'
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
    click_button 'Sign up'

    expect(page).not_to have_text 'Welcome! You have signed up successfully.'
  end

  it "doesn't sign up user if password is to short" do
    visit new_user_registration_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'short'
    click_button 'Sign up'

    expect(page).to have_text 'Password is too short (minimum is 6 characters)'
  end
end
