require 'rails_helper'

RSpec.describe 'Like', type: :model do
  describe 'associations' do
    it 'belongs to post' do
      like = Like.reflect_on_association(:user)
      expect(like.macro).to eql(:belongs_to)
    end
    it 'belongs to user' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eql(:belongs_to)
    end
  end
end
