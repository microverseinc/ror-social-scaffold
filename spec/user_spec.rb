require 'rails_helper'

describe User, type: :model do
  context 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:friends) }
    it { should have_many(:inverse_friendships) }
  end
end
