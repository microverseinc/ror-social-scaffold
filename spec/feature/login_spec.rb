require 'rails_helper'

describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'wintan@gmail.com', password: 'wintan', name: 'wintan')
  end
  it 'signs @user in' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'wintan@gmail.com'
    fill_in 'Password', with: 'wintan'
    click_button 'Log in'
    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed in successfully.')
  end
  it 'does not sign in with wrong info' do
    visit '/users/sign_in'
    fill_in 'Email', with: 'wrong@gmail.com'
    fill_in 'Password', with: 'wrong'
    click_button 'Log in'
    expect(page).to have_text('Invalid Email or password.')
  end
end
