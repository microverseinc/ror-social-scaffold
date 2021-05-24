require 'rails_helper'

feature 'Sends an invitation' do
  scenario 'with valid email and password' do
    visit root_path
    expect(page).to have_content('You need to sign in')
  end
end
