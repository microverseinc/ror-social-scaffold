require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
