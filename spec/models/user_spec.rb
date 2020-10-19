require 'rails_helper'

RSpec.describe User, type: :model do
  context 'before publication' do 
    it 'cannot have comments' do   #
      user = User.new(email: 'testuser@gmail.com', password: 'password').save
      expect(user).to eq(false)
    end
  end
end
