require 'rails_helper'

describe User, type: :model do
  it 'is valid with all attributes' do
    expect(User.new(name: 'wandji', email: 'wandji@email', password: '111111')).to be_valid
  end
  it 'is not valid with name longer than 20 characters' do
    expect(User.new(name: 'wandjirrrrrrrrrrttttttt', email: 'wandji@email', password: '111111')).to_not be_valid
  end
end