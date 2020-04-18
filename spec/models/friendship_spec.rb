require 'rails_helper'

RSpec.describe Friendship, type: :model do
  	# let(:friend) do 
  	# 	User.create(id: 1, name: 'Foobar', email: 'foo@bar.com', password: 'foobar')
  	# 	User.create(id: 2, name: 'Foobar', email: 'foo@bar.com', password: 'foobar')
  	# end

    let(:friendship) do
     Friendship.new(user_id: 1, friend_id: 2, confirmed: true)
    end

	  it 'is valid with all of the correct fields' do
      expect(friendship.valid?).to eql(true)
  	end

  	it 'is not valid without user_id' do
  		friendship.user_id = nil
  		expect(friendship).to_not be_valid
  	end

  	it 'is not valid without user_id' do
  		friendship.friend_id = nil
  		expect(friendship).to_not be_valid
  	end


  	it 'is not valid if the requested friend doesnt exist' do
  		friendship.friend_id = 3
  		expect(friendship).to_not be_valid
  	end

  	describe 'Validations' do
	    it { should validate_presence_of :user_id}
	    it { should validate_presence_of :friend_id }
	end

    describe 'associations' do
    	it { should belong_to :user }
    	it { should belong_to :friend }
    end
end