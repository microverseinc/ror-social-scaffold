require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    it 'should be build from user' do
      expect(Post.new(user_id: 2, content: 'this is a test')).to_not be_valid
    end
  end
end
