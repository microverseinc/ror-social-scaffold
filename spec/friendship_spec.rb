require 'rails_helper'

RSpec.describe Friendship, type: :model do
  it 'validates name, username and email' do
    user = User.new(name: '')
    expect(user.valid?).to be(false)
  end

  describe 'ActiveRecord associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:friend).class_name('User') }
  end
end
