ommrequire 'rails_helper'

RSpec.feature 'Create new User', type: :feature do
  scenario 'create friendship between two users' do
    visit '/users/sign_up'

    fill_in 'user_name', with: 'Carl'
    fill_in 'user_email', with: 'carl@bond.com'
    fill_in 'user_password', with: 'foobar'
    fill_in 'user_password_confirmation', with: 'foobar'
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')

    click_on 'Sign out'
    expect(page).to have_text('You need to sign in or sign up before continuing.')

    visit '/users/sign_up'

    fill_in 'user_name', with: 'Carlito'
    fill_in 'user_email', with: 'carlito@carlito.com'
    fill_in 'user_password', with: 'foobar2'
    fill_in 'user_password_confirmation', with: 'foobar2'
    click_button 'Sign up'
    expect(page).to have_text('Welcome! You have signed up successfully.')
    user_id = User.find_by(email: 'carlito@carlito.com').id
    click_on 'All users' 
    expect(page).to have_button('Add friend')
    click_on('Add friend', :match => :first)
  end
end