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
    expect(subject).to be_valid
  end

  it 'is not valid if friend_id is nil' do
    subject.friend_id = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid if user_id is nil' do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid if the friendship already exists' do
    Friendship.create(user_id: User.first.id, friend_id: User.last.id)
    expect(subject).to_not be_valid
  end
end
