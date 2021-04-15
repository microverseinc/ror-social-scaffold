require 'rails_helper'

describe 'signin procedure', type: :feature do
  before :each do
    User.create(email: 'wintan@gmail.com', password: 'password_wintan', name: 'wintan')
    User.create(email: 'lopez@gmail.com', password: 'password_lopez', name: 'lopez')
    visit '/users/sign_in'
    fill_in 'Email', with: 'grace@gmail.com'
    fill_in 'Password', with: 'password_winlopez'
    click_button 'Log in'
  end
end
