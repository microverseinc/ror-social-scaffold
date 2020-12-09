require 'rails_helper'
RSpec.describe 'Invite a user for friendship', type: :feature do
  before(:each) do
    @user = User.create(name: 'somename', email: 'a@a.com', password: '123456')
  end
  scenario 'invite a user' do
    visit users_path
    page.should have_css('form input[type="submit"]')
  end
end
