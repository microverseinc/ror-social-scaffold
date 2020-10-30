require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:comment) do
    Comment.new(user_id: 1, post_id: 1, content: 'hello world')
  end

  context 'Association test for Comment model' do
    it 'should belong to post' do
      t = Comment.reflect_on_association(:post)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belong to User' do
      t = Comment.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  context 'Validation test for Comment model' do
    it 'should valid content' do
      # comment.content = ''
      expect(comment.content).not_to be_empty
    end
  end
end
