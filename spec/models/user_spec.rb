require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  # subject { @user }

  context 'when valid' do
    it 'should respond to name' do
      expect(@user).to respond_to(:name)
    end
  
    it 'should respond to email' do
      expect(@user).to respond_to(:email)
    end
    
    it 'should respond to password' do
      expect(@user).to respond_to(:password)
    end
  end

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end
end
