require 'rails_helper.rb'
require 'spec_helper'
# User Capybara test

describe 'the signin process', type: :feature do
  before :each do
    @test_friend = User.create!({ name: 'Alex',
                                  email: '123@gmail.com',
                                  password: '123123',
                                  password_confirmation: '123123' })
    @test_user = User.create!({ name: 'Kelyn',
                                email: '234@gmail.com',
                                password: '123123',
                                password_confirmation: '123123' })
  end
  it 'Display message when creating a new user' do
    visit '/users/sign_up'

    fill_in 'user_name', with: '123123a'
    fill_in 'user_email', with: '123a1@gmail.com'
    fill_in 'user_password', with: '123123a'
    fill_in 'user_password_confirmation', with: '123123a'

    click_button('Sign up')

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
  it 'Display message when logged in' do
    visit '/users/sign_in'

    fill_in 'user_email', with: @test_user.email
    fill_in 'user_password', with: @test_user.password

    click_button('Log in')

    expect(page).to have_content 'Signed in successfully.'
  end
  it 'Display message when sign out' do
    visit '/users/sign_in'

    fill_in 'user_email', with: @test_user.email
    fill_in 'user_password', with: @test_user.password
    click_button('Log in')
    first(:link, 'Sign out').click

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
