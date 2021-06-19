require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'belong to user' do
    t = Friendship.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'belong to friend' do
    t = Friendship.reflect_on_association(:friend)
    expect(t.macro).to eq(:belongs_to)
  end
end
