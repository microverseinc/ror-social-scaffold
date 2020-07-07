require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'testing asociations' do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:confirmed_friendships) }
    it { should have_many(:pending_friendships) }
    it { should have_many(:inverted_pending_friendships) }
    it { should have_many(:inverted_confirmed_friendships) }
  end

  describe 'testing validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(20) }
  end
 
  describe "#valides" do
    it 'validates user instanse' do
      user = User.new(name:'Bekhzod', password:'1234567', email:'email@mail.ru')
      expect( user).to be_valid
    end

    it 'validates user instanse' do
      user = User.new(name:'Bekzod', password:'1234567', email:'emazil@mail.ru')
      user.name = ''
      expect( user).not_to be_valid
    end
  end
  
end
