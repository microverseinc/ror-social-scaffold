require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  context 'when valid' do
    it 'should be valid' do
      expect(@user).to be_valid
    end
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

  context 'when name is not present' do
    before { @user.name = ' ' }
    it 'should not be valid' do
      expect(@user).not_to be_valid
    end
  end

  context 'when email is not present' do
    before { @user.email = ' ' }
    it 'should not be valid' do
      expect(@user).not_to be_valid
    end
  end

  context 'when name is too long' do
    before { @user.name = 'a' * 51 }
    it 'should not be valid' do
      expect(@user).not_to be_valid
    end
  end

  context 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  context 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  context 'when email address is already taken' do
    before do
      @user_with_same_email = FactoryBot.create(:user)
      @user_with_same_email.email = @user.email
      @user_with_same_email.save
    end

    it 'should not be valid' do
      expect(@user_with_same_email).not_to be_valid
    end
  end

  context 'email address with mixed case' do
    let(:mixed_case_email) { 'Foo@ExAMPle.CoM' }

    it 'should be saved as all lower-case' do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  context 'when sends friend requests' do 
    before do
      @sunday = FactoryBot.create(:user)
      @ahmed = FactoryBot.create(:user)
    end

    it 'should have pending requests' do
      expect{ @sunday.send_request(@ahmed) }.to change{ @sunday.pending_friends.count }.by(1)
    end
  end

  context 'when receives friend requests' do 
    before do
      @sunday = FactoryBot.create(:user)
      @ahmed = FactoryBot.create(:user)
    end

    it 'should have received request' do
      expect { @ahmed.send_request(@sunday) }.to change{ @sunday.friend_requests.count }.by(1)
    end
  end

  context 'when accepts a friend request' do
    before do
      @sunday = FactoryBot.create(:user)
      @ahmed = FactoryBot.create(:user)
      @ahmed.send_request(@sunday)
      @sunday.accept_friend(@ahmed)
    end

    it 'Sunday should be Ahmed\'s friend' do
      expect(@ahmed.friend?(@sunday)).to eq(true)
    end

    it 'Ahmed should be Sunday\'s friend' do
      expect(@sunday.friend?(@ahmed)).to eq(true)
    end

    it 'should not have pending request from the same user' do
      expect(@sunday.friend_requests.include?(@ahmed)).not_to eq(true)
    end
  end

  context 'when deleted' do
    before do
      @sunday = FactoryBot.create(:user)
      @ahmed = FactoryBot.create(:user)
      Friendship.create!(user_id: @ahmed.id, friend_id: @sunday.id, confirmed: true)
    end

    it 'should destroy his friendships' do
      expect { User.find(@sunday.id).destroy}.to change{ @ahmed.reload.friends.count }.by(-1)
    end
  end
end
