require 'rails_helper'

describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'user999@gmail.com', password: '123456', name: 'User999')
  end

  it 'signs @user in' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user999@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed in successfully.')
  end

  it 'does not sign in with wrong info' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'user9999@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_text('Invalid Email or password.')
  end
end
