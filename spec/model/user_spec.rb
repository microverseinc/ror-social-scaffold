require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Oscar', email: 'a@mail.com', password: '123456') }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it 'should have many posts' do
    t = User.reflect_on_association(:posts)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have many comments' do
    t = User.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have many received_friendships' do
    t = User.reflect_on_association(:received_friendships)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have many sent_friendships' do
    t = User.reflect_on_association(:sent_friendships)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have many requesting_friends' do
    t = User.reflect_on_association(:requesting_friends)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have many requested_friends' do
    t = User.reflect_on_association(:requested_friends)
    expect(t.macro).to eq(:has_many)
  end
end
