require 'rails_helper'

RSpec.describe User do
  fixtures :users

  subject(:user) { users(:John) }
  let(:invalid_user) { User.new }

  describe 'Validity with name,password and email from fixtures' do
    it 'should be valid from fixtures' do
      expect(user).to be_valid
    end
  end

  describe :invalidity do
    it 'should not be valid with blank fields' do
      expect(invalid_user).not_to be_valid
    end
  end
end
