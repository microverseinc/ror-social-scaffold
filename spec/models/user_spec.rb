require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:inverse_friendships).class_name('Friendship') }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  # describe "scopes" do
  #   let(:user1) { User.create(name: 'Marshall', email: 'uimarshall@gmail.com', password: 'pass123') }
  #   let(:user2) { User.create(name: 'Marshall2', email: 'uimarshall2@gmail.com', password: 'pass123') }
   
  #  it 'return false when there is not friendship' do 
  #    expect(user1.friends.to_a).to eq([])
  #   end
   
  #  it 'It should check for existence friendship' do 
  #   friendship = Friendship.create!(user_id: user1.id,friend_id:user2.id)
  #    expect(user1.friends.to_a).to eq(friendship)
  
  #   end
  # end  
end
