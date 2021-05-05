require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create(name:'user_tes1', email:'mail1@mail.com', password: 'password') } 
  let(:user2) { User.create(name:'user_test2', email:'mail2@mail.com', password: 'password') } 
  let(:user3) { User.create(name:'user_test2', email:'mail2@mail.com', password: 'password') } 
  let(:invalid_user) { User.create(name:nil, email:'mail3@mail.com', password: 'password') }

  describe 'An User can be created it has all the validations' do
    it 'Has email, name and password' do
      expect(user1).to be_valid
    end

    it "Is invalid if name, email or password are not present" do
      expect(invalid_user).to_not be_valid 
    end 
  end

end
