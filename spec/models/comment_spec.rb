require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it 'should validate presence of content' do
      User.create!(email: 'abc@example.com', password: '123456', name: 'Example')
      Post.create!(user_id: 1, content: 'ascascacascsacsac')
      comment = Comment.create!(user_id: 1, post_id: 1, content: 'adskcascascsaicaccscxisahxsa')

      expect(comment.valid?).to be true
    end

    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:post_id) }
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(200).with_long_message('200 characters in comment is the maximum allowed.') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
