require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:u1) { User.create(name: 'Bishoy', email: 'Bishoy@gmail.com', password: '246888') }
  let(:u2) { User.create(name: 'Felix', email: 'Felix@gmail.com', password: '246888') }

  it 'It check if the friendship already exist' do
    Friendship.create({ sender_id: u1.id, receiver_id: u2.id })
    expect(Friendship.requested_before?(u1.id, u2.id)).to eql(true)
    expect(Friendship.requested_before?(u1.id, 3)).to eql(false)
  end
end
