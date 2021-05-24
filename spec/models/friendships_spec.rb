require 'rails_helper'

RSpec.describe Friendship do
  fixtures :users
  fixtures :friendships

  subject(:one) { friendships(:one) }

  describe 'Validity from fixture with user_id,friend_id' do
    it 'should be valid' do
      friendship = Friendship.new(user_id:1,friend_id:2,confirmed:true)
      expect(friendship).to be_valid
    end
  end

  describe :invalid_name do
    it "should have valid name" do
      user = User.new(name:'',email:'some@gmail.com')
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
      expect(user).not_to be_valid
    end
  end

  describe :invalid_password do
    it "should have valid name" do
      user = User.new(name:'samrood',email:'some@gmail.com')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
      expect(user).not_to be_valid
    end
  end

end
