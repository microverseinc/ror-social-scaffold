require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:sender1) { User.create(name: 'Oscar', email: 'o@mail.com', password: '123456') }
  let(:receiver1) { User.create(name: 'Alexis', email: 'a@mail.com', password: '123456') }
  subject { Friendship.create(requesting_friend: sender1, requested_friend: receiver1, status: false) }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a sender' do
    subject.requesting_friend = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid without a receiver' do
    subject.requested_friend = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid if it takes an already created sender and receiver combination' do
    Friendship.create(requesting_friend: sender1, requested_friend: receiver1)
    expect(subject).to_not be_valid
  end
  it 'is not valid if the sender_id and receiver are the same' do
    subject.requested_friend = sender1
    expect(subject).to_not be_valid
  end
  it 'belongs to requested_friend' do
    t = Friendship.reflect_on_association(:requested_friend)
    expect(t.macro).to eq(:belongs_to)
  end
  it 'belongs to requesting_friend' do
    t = Friendship.reflect_on_association(:requesting_friend)
    expect(t.macro).to eq(:belongs_to)
  end
end
