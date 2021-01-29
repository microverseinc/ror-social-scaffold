require 'rails_helper'

RSpec.describe 'sign in process', type: :feature do
  before(:each) do
    User.create(email: 'user@email.com', password: 'password', name: 'user1')
  end

  it 'signs if user exits' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(current_path).to eq(root_path)
  end

  it 'raise error if wrong password' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'raise error if wrong email' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: ''
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'raise error if fields empty' do
    visit '/users/sign_in'
    within('#new_user') do
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
  end

  it 'response 200 when visits page' do
    visit '/users/sign_in'
    expect(page.status_code).to be(200)
  end
end
