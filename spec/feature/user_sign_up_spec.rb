require 'rails_helper'
describe 'the signup process', type: :feature do
  before :each do
    User.create(email: 'jack@gmail.com', password: '123456')
  end

  it 'signs me up' do
    visit root_path
    click_link_or_button 'Sign up'
    fill_in 'Name', with: 'Jack Bauer'
    fill_in 'Email', with: 'jack@gmail.com'
    fill_in 'Password', with: '123456'

    click_button 'Sign up'
    expect(page).to have_content 'Sign up'
  end
end
