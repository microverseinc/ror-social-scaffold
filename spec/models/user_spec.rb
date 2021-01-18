require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it ' ensures name not blank' do
      user = User.new(name: '').save
      expect(user).to eql(false)
    end
  end
end
