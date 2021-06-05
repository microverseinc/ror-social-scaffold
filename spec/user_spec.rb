require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:confirmed_friendships) }
    it { should have_many(:friends) }
    it { should have_many(:pending_friendships) }
    it { should have_many(:pending_friends) }
  end
end
