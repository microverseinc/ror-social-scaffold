require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Associations' do
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
