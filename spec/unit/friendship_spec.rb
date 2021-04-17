require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Associations' do
    it { should belong_to(:receiver) }
    it { should belong_to(:requester) }
  end
end
