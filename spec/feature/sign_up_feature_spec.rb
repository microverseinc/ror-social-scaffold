require 'rails_helper'

RSpec.describe 'sign up process', type: :feature do
  it 'returns success if new user' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page.status_code).to be(200)
    expect(current_path).to eq(root_path)
  end

  it 'raise error if name blank' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Name', with: ''
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content "Name can't be blank"
  end

  it 'raise error if email blank' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: ''
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content "Email can't be blank"
  end

  it 'raise error if password blank and password conf filled' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content "Password can't be blank"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it 'raise error if password filled and password conf blank' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: ''
    end
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it 'raise error if password filled and password conf does not match' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: 'password'
    end
    click_button 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it 'raise error if password blank and password conf blank' do
    visit '/users/sign_up'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Name', with: 'user1'
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
    end
    click_button 'Sign up'
    expect(page).to have_content "Password can't be blank"
  end
end
