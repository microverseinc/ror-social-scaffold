require 'rails_helper'

RSpec.describe User, type: 'model' do
  context 'association' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:accepted_friendships) }
    it { should have_many(:pending_friendships) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end
end
