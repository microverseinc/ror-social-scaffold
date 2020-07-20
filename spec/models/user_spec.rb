require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'test_user', email: 'test_user@test.com',
                        password: '123456', password_confirmation: '123456')
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid when name is absent' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid when length of name is more than 20' do
    subject.name = 'Taofeek Olalere Teekaytech Laravel advocate'
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should have_many(:friends).class_name('FriendRequest') }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:friend_requests) }
  end
end
