require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'rspec', email: 'rspec@test.com', password: '123456') }
  let(:inv_user) { User.create(name: '', email: 'rspec@test.com', password: '123456') }
  let(:posts) { User.reflect_on_association(:posts).macro }
  let(:comments) { User.reflect_on_association(:comments).macro }
  let(:likes) { User.reflect_on_association(:likes).macro }
  let(:friendships) { User.reflect_on_association(:friendships).macro }
  let(:inverse_friendships) { User.reflect_on_association(:inverse_friendships).macro }

  it 'checks user validity' do
    @user = User.create(name: 'rspec', email: 'rspec@test.com', password: '123456')
    expect(@user).to be_valid
  end

  it 'user name should not be empty' do
    expect(inv_user).to_not be_valid
  end

  it 'checks correct association' do
    expect(posts).to eq(:has_many)
  end

  it 'check correct association' do
    expect(comments).to eq(:has_many)
  end

  it 'check correct association' do
    expect(likes).to eq(:has_many)
  end

  it 'check correct association' do
    expect(friendships).to eq(:has_many)
  end

  it 'check correct association' do
    expect(inverse_friendships).to eq(:has_many)
  end
end
