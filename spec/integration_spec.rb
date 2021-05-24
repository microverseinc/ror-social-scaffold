require 'rails_helper'
require './spec/support/helpers'

feature 'Friendship integration testing by requests sent and accepted' do
  background do
    sam = User.new(name: 'samrood', email: 'user@example.com', password: 'password')
    sign_up_with(sam)
  end

  scenario 'home page has new post input tag' do
    page.has_selector?('#post_content')
  end

  scenario 'users page has users' do
    visit users_path
    page.has_selector?('.user')
  end
end
