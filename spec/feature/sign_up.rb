require_relative '../rails_helper'

RSpec.describe 'Webpage workflow', type: :system do
  it 'Password is too short' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Frodo'
    fill_in 'Email', with: 'frodo@hotmail.com'
    fill_in 'Password', with: 'lord'
    fill_in 'Password confirmation', with: 'lord'
    click_on 'Sign up'
    sleep(3)
    expect(page).to have_content('Password is too short (minimum is 6 characters)')
  end

  it 'Password and password confirmation are different' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Frodo'
    fill_in 'Email', with: 'frodo@hotmail.com'
    fill_in 'Password', with: 'the'
    fill_in 'Password confirmation', with: 'lord'
    click_on 'Sign up'
    sleep(3)
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'Successful sign up' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Frodo'
    fill_in 'Email', with: 'frodo@hotmail.com'
    fill_in 'Password', with: 'thelord'
    fill_in 'Password confirmation', with: 'thelord'
    click_on 'Sign up'
    sleep(3)
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
