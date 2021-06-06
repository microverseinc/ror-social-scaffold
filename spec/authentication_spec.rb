require 'rails_helper'

RSpec.describe 'Siging Up', type: :feature do
  scenario 'Sign up with valid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Mrigorir'
    fill_in 'Email', with: 'mrigorir@mrigorir.com'
    fill_in 'Password', with: 'qweqwe'
    fill_in 'Password confirmation', with: 'qweqwe'
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to have_content('Mrigorir')
  end

  scenario 'Sign up with invalid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Marco'
    fill_in 'Email', with: 'test.com'
    fill_in 'Password', with: 'qweqwe'
    fill_in 'Password confirmation', with: 'rrtyuio'
    click_on 'Sign up'
    sleep(3)
    visit root_path
    expect(page).to_not have_content('Marco')
  end
end

RSpec.describe 'Loggin In', type: :feature do
  let(:user) { User.create(name: 'Marco Parra', email: 'mrigorir@gmail.com', password: 'qweqwe12') }
  scenario 'Log in with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to have_content('Marco Parra')
  end

  scenario 'Log in with invalid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: 'cool@gmail.com'
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    expect(page).to_not have_content('cool')
  end
end
