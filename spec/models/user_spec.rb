require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  describe 'validations' do

    context 'with valid attributes' do
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

      it 'should be valid when email format is valid' do
        addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
  
    context 'with invalid attributes' do

      it 'should not be valid when name is blank' do
        @user.name = ' '
        expect(@user).not_to be_valid
      end
    end
  
    it 'should not be valid when email is blank' do
      @user.email = ' '
      expect(@user).not_to be_valid
    end

    it 'should not be valid when name is too long' do
      @user.name = 'a' * 51
      expect(@user).not_to be_valid
    end

    it 'should be invalid when email format is invalid' do
      addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  
    it 'should not be valid when email address is already taken' do
      @user_with_same_email = FactoryBot.create(:user)
      @user_with_same_email.email = @user.email
      @user_with_same_email.save
      expect(@user_with_same_email).not_to be_valid
    end

    it 'should be saved as all lower-case' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq(mixed_case_email.downcase)
    end
  end

  describe 'friendship associations' do
    before do
      @sunday = FactoryBot.create(:user)
      @ahmed = FactoryBot.create(:user)
    end
  
    it 'should have pending requests with friend requests sent' do
      expect { @sunday.send_request(@ahmed) }.to change { @sunday.pending_friends.count }.by(1)
    end
  
    it 'should have received request with friend requests received' do
      expect { @ahmed.send_request(@sunday) }.to change { @sunday.friend_requests.count }.by(1)
    end
  
    context 'when accepts a friend request' do
      before do
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

    it 'should have friend requests decrease by 1 when a friend request is declined' do
      @ahmed.send_request(@sunday)
      expect { @sunday.reject_friend(@ahmed) }.to change { @sunday.friend_requests.count }.by(-1)
    end

    it 'should destroy user friendships when a user is deleted' do
      Friendship.create!(user_id: @ahmed.id, friend_id: @sunday.id, confirmed: true)
      expect { User.find(@sunday.id).destroy }.to change { @ahmed.reload.friends.count }.by(-1)
    end
  end

  describe "posts associations" do

    before { @user.save } #= FactoryBot.create(:user) }
    let!(:older_post) do
      FactoryBot.create(:post, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_post) do
      FactoryBot.create(:post, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right posts in the right order" do
      expect(@user.posts).to eq([newer_post, older_post])
    end
  end
end
