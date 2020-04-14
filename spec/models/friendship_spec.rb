require 'rails_helper'

RSpec.describe Friendship, type: :model do
	let(:friend) do 
		User.create(id: 1, name: 'Foobar', email: 'foo@bar.com', password: 'foobar')
		User.create(id: 2, name: 'Foobar', email: 'foo@bar.com', password: 'foobar')
		Friendship.new(user_id: 1, friend_id: 2, confirmed: true)
	end

	it 'is valid with all of the correct fields' do
		expect(friend).to be_valid
  	end

  	it 'is not valid without user_id' do
  		friend.user_id = nil
  		expect(friend).to_not be_valid
  	end

  	it 'is not valid without user_id' do
  		friend.friend_id = nil
  		expect(friend).to_not be_valid
  	end


  	it 'is not valid if the requested friend doesnt exist' do
  		friend.friend_id = 3
  		expect(friend).to_not be_valid
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