require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'User creation' do
    visit new_user_registration_path
    fill_in 'user_name', with: 'lalo'
    fill_in 'user_email', with: 'lalo@new.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully')
  end
  context 'validation tests' do
    it ' ensures name not blank' do
      user = User.new(name: '',password: '123456').save
      expect(user).to eql(false)
    end
    it ' ensures password lenght greater than or equals 6' do
      user = User.new(name: 'one',password: '123').save
      expect(user).to eql(false)
    end
  end

end
