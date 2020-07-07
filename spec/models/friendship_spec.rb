require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'associations to test' do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end

  before(:all) do
    User.create(name: 'Bekhzod', password: '1234567', email: 'email@mail.ru')
    User.create(name: 'Javiar', password: '1234567', email: 'emaial@ail.ru')
  end

  describe '#valides' do
    it 'validates friendship instance' do
      friendship = Friendship.new(user_id: 2, friend_id: 1)
      expect(friendship).to be_valid
    end

    it 'validates friendship instance' do
      friendship = Friendship.new(user_id: 2, friend_id: 1)
      friendship.user_id = ''
      expect(friendship).not_to be_valid
    end
  end
end
