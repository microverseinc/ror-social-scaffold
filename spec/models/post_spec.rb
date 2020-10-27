require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation content' do
    it 'ensures content presence' do
      post = Post.new(content: '').save
      expect(post).to eql(false)
    end

    it 'should save successfully' do
      post = Post.new(content: 'Something new is here!').save
      expect(post).to eql(false)
    end
  end
end
