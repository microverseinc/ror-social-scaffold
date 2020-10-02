require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }

  context 'when name is blank' do
    it { expect(@user).to be_valid }
  end

  context 'It should respond to all fields' do
    it { expect(@user).to respond_to(:name) }
    it { expect(@user).to respond_to(:email) }
    it { expect(@user).to respond_to(:password) }
  end

  context 'when all is present' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  context 'Check association' do
    it { should have_many(:friendships) }
    it { should have_many(:posts) }
    it { should have_many(:likes) }
    it { should have_many(:comments) }
    it { should have_many(:inverse_friendships) }
  end
end
