require 'rails_helper'
describe 'the signin process', type: :feature do
  before :each do
    User.create(email: 'jack@gmail.com', password: '123456')
  end

  it 'signs me in' do
    visit root_path
    click_link_or_button 'Sign in'
    fill_in 'Email', with: 'jack@gmail.com'
    fill_in 'Password', with: '123456'

    click_button 'Log in'
    expect(page).to have_content 'Sign in'
  end
end
