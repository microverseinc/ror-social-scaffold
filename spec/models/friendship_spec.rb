require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before(:all) do
    @user1 = User.create(id: 1, name: 'Ismael', email: 'ismael@gmail.com', password: '123456',
                         password_confirmation: '123456')
    @friend = User.create(id: 2, name: 'Ixboy', email: 'ixboy@gmail.com', password: '123456',
                          password_confirmation: '123456')
    @friendship = Friendship.create(user_id: 1, friend_id: 2, status: 'accepted')
  end
  it 'should have valid attributes' do
    expect(@friendship).to be_valid
  end

  it 'should update status to accepted' do
    @friendship.update(status: 'accepted')
    expect(Friendship.find_by_status('accepted')).to eq(@friendship)
  end

  it 'should update status to reject' do
    @friendship.update(status: 'accepted')
    expect(Friendship.find_by_status('accepted')).to eq(@friendship)
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  context 'friendship' do
    let(:sender) { @user1 }
    let(:receiver) { @friend }

    it 'can request a frienship' do
      invitation = Friendship.request(@user1, @friend)
      @request1 = Friendship.find(2)
      @request2 = Friendship.find(3)
      expect(@request1.status).to eq('pending')
      expect(@request2.status).to eq('requested')
      expect(invitation.status?).to be_truthy
    end
  end
end
