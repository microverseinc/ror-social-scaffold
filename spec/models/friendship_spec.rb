require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'should return boolean(T|F)' do
    it { should allow_value(true).for(:confirmed) }
    it { should allow_value(false).for(:confirmed) }
  end

  context 'Friendship belong to' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
