require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validation' do
    p = Post.new(user_id: 2, content: 'You wanna say something?')
    it 'should have a post ' do
      p.content = nil
      expect(Post.new).to_not be_valid
    end
  end
end