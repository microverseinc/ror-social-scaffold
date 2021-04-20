require 'rails_helper'


RSpec.describe User, type: :model do
	subject(:user) { User.new(name: 'Mickey', email: 'mickey@mail.com', password: 'tester') }

	describe 'Valid' do
		it { should validate_length_of(:name).is_at_most(20) }

    it { should_not allow_value('').for(:name) }
	end
	
  describe 'User' do
    it { should have_many(:posts) }

    it { should have_many(:comments).dependent(:destroy) }

    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:friendships) }
  end
end
