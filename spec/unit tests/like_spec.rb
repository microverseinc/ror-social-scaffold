require 'rails_helper'
RSpec.describe Like do
  before :each do
    User.create(name: 'John', email: 'example001@example.com',
                password: 'Secret1', password_confirmation: 'Secret1')
    Post.create(user_id: User.first.id,
                content: "Can't believe how exepensive poatoes have become over the past year!")
  end

  describe 'create' do
    it 'rejects request if user doesn\'t exist' do
      like = Like.new(user_id: 0, post_id: Post.first.id)
      expect(like.valid?).to eq(false)
    end
    it 'rejects request if post doesn\'t exist' do
      like = Like.new(user_id: User.first.id, post_id: 0)
      expect(like.valid?).to eq(false)
    end
    it 'accepts request if all values are correct' do
      like = Like.new(user_id: User.first.id, post_id: Post.first.id)
      expect(like.valid?).to eq(true)
    end
  end
end
