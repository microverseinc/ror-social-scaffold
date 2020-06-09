require 'rails_helper'

describe Friendship do
  subject { Friendship.new(user_id: User.first.id, friend_id: User.last.id) }

  let!(:user1) { User.create(name: name, email: email, password: password) }
  let(:name) { 'Franco' }
  let(:email) { 'franco@mail.com' }
  let(:password) { '123123' }
  
  let!(:user2) { User.create(name: name, email: email, password: password) }
  let(:name) { 'Zak' }
  let(:email) { 'zak@mail.com' }
  let(:password) { '123123' }

  it { should belong_to(:user) }
  it { should belong_to(:friend) }

  it 'is valid with valid attributes' do
    Friendship.create(user_id: 1, friend_id: 2)
    expect(subject).to be_valid
  end

  it 'is no valid without valid attributes' do
    Friendship.create(user_id: 1)
    expect(subject).to_not be_valid
  end

  
end