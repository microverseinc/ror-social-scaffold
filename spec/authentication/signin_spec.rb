require 'rails_helper'

describe 'User signs in', type: :system do
  before do
    @user = User.create(name: 'John Doe', email: 'john@doe', password: '000000', password_confirmation: '000000')
  end

  it 'signs in @user with correct credentials' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    expect(page).to have_text 'Signed in successfully.'
    expect(page).to have_current_path root_path
  end

  it "doesn's sign in user with unregistered account" do
    visit new_user_session_path
    fill_in 'Email', with: 'Johndoe@gmail.com'
    fill_in 'Password', with: 'FakePassword123'
    click_button 'Log in'

    expect(page).to have_no_text 'Signed in successfully.'
    expect(page).to have_text 'Invalid Email or password.'
  end

  it "doesn's sign in user with invalid password" do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'FakePassword123'
    click_button 'Log in'

    expect(page).to have_no_text 'Signed in successfully.'
    expect(page).to have_text 'Invalid Email or password.'
  end

  it "doesn's sign in user with invalid email" do
    visit new_user_session_path
    fill_in 'Email', with: 'Johndoe@gmail.com'
    fill_in 'Password', with: @user.password
    click_button 'Log in'

    expect(page).to have_no_text 'Signed in successfully.'
    expect(page).to have_text 'Invalid Email or password.'
  end
end
