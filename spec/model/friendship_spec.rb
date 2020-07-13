require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
