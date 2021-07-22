require 'rails_helper'
require 'spec_helper'

RSpec.describe Friendship, type: :feature do
  let(:person1) { User.create!(name: 'Person 1', email: 'person1@gmail.com', password: 'password') }
  let(:person2) { User.create!(name: 'Person 2', email: 'person2@gmail.com', password: 'password') }

  scenario 'View users list' do
    person1.save
    person2.save
    visit users_path
    fill_in 'Email', with: person1.email
    fill_in 'Password', with: person1.password
    click_on 'Log in'
    visit users_path
    expect(page).to have_content("Name: #{person1.name}")
  end
end
