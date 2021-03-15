require 'rails_helper'

RSpec.describe Friendrequest, type: :model do
  describe 'Associations' do
    it { should belong_to(:friend).class_name('User') }
    it { should belong_to(:user).class_name('User') }
  end

  before(:all) do
    User.create(name: 'angela', email: 'angela@gmail.com', password: '012345')
    User.create(name: 'sharon', email: 'sharon@gmail.com', password: '012345')
  end

  it 'is valid with valid attributes' do
    expect(User.first.friendrequests.new(friend_id: User.second.id)).to be_valid
  end

  it 'is invalid when no attribute is defined' do
    expect(User.first.friendrequests.new).to_not be_valid
  end
end
