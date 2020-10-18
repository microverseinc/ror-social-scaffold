require 'rails_helper'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.describe Friendship, type: :model do
  before :each do
    @requester = User.create(name: 'Andy Umeh', email: 'a.example@email.com',
                             password: 'secretpass')
    @requestee = User.create(name: 'Umair Faruk', email: 'u.example@email.com',
                             password: 'password')
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'validations' do
    subject { Friendship.create(user_id: @requester.id, friend_id: @requestee.id, confirmed: false) }
    it { should validate_presence_of(:friend_id) }
    it { should validate_presence_of(:user_id) }
  end
end
