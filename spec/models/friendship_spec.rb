require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    User.create(name: 'JonDoe', email: 'jondoe@example.com', password: 'password', password_confirmation: 'password')
    User.create(name: 'JaneDoe', email: 'janedoe@example.com', password: 'password', password_confirmation: 'password')
  end

  it 'Sends request' do
    user = User.last
    login_as(user, scope: :user)
    visit '/users'
    click_link 'Send request to JonDoe'
    expect(page).to have_content 'Friendship request sent!'
  end
end
