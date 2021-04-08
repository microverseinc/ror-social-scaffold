require 'rails_helper'

describe User, type: :model do
  # Model Tests
  context 'check CRUD actions work with correct params' do
    before do
      @user = User.create(name: 'John Smith', email: 'john.smith@email.com', password: 'abc123', gravatar_url: '')
    end

    it 'checks that a user can be created' do
      expect(@user).to be_valid
    end

    it 'checks that a user can be read' do
      expect(User.find_by(name: 'John Smith')).to eq(@user)
    end
  end

  context 'CRUD actions won\'t work with incorrect params' do
    before do
      @user = User.create(email: 'john.smith@email.com', password: 'abc123', gravatar_url: '')
    end

    it 'checks that a user cannot be created' do
      expect(@user).not_to be_valid
    end

    it 'checks that a user cannot be read' do
      expect(User.find_by(name: 'John Smith')).not_to eq(@user)
    end
  end

  # Association Tests
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:likes) }
end
