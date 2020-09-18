require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user = User.create(name: 'yahir', email: 'yahir@example.com', password: 'password')
    @friend = User.create(name: 'mauricio', email: 'mauricio@example.com', password: 'password')
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  describe 'validations' do
    subject { Friendship.create(user_id: @user.id, friend_id: @friend.id, confirmed: false) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
  end
end
