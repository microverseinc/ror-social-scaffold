require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:friendships)}
    it { should have_many(:inverse_friendships).with_foreign_key('friend_id').class_name('Friendship')}
    it { should have_many(:posts)}
    it { should have_many(:comments)}
    it { should have_many(:likes)}
  end

  describe 'Validator' do
    subject { User.create(name: 'Test user', email: 'textor@test.com', password: 'testor') }

    it { should validate_presence_of(:name)}
    it { should validate_length_of(:name) }
  end
end