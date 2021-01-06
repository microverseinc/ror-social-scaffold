require 'rails_helper.rb'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships).class_name('Friendship') }
  end
end
