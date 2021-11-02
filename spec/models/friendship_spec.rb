require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Associations' do
    it { should belong_to(:friend) }
    it { should belong_to(:user) }
  end
end
