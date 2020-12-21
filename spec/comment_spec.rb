require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    it 'should be built from user' do
      expect(Comment.new(user_id: 2)).to_not be_valid
    end
  end
end