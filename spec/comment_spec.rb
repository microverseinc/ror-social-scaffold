require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validation' do
    p = Post.new(user_id: 2, content: 'You wanna say something?')
    it 'should have content' do
      p.content = nil
      expect(Comment.new(user_id: 2)).to_not be_valid
    end
  end
end