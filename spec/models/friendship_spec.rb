require 'rails_helper'

RSpec.describe Friendship, type: :model do
  	 
  	let(:user1){User.create(name: 'Foobar', email: 'foo@bar.com', password: 'foobar')}
  	let(:user2){User.create(name: 'Fourbar', email: 'four@bar.com', password: 'fourbar')}
  	let(:friendship) { Friendship.new(user_id: user1.id, friend_id: user2.id) }

	  # it 'is valid with all of the correct fields' do
   #    expect(friendship).to be_valid
  	# end

    it 'has to have a friend_id' do
      expect(friendship.friend_id).to eq(user2.id)
    end

  	it 'is not valid without user_id' do
  		friendship.user_id = nil
  		expect(friendship).to_not be_valid
  	end

  	it 'is not valid without friend_id' do
  		friendship.friend_id = nil
  		expect(friendship).to_not be_valid
  	end


  	it 'is not valid if the requested friend doesnt exist' do
  		friendship.friend_id = 3
  		expect(friendship).to_not be_valid
  	end

    it 'returns an error for missing friend_id' do
      friendship.friend_id = nil
      expect(friendship.save).to eq(false)
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