require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it 'should validate presence of content' do
      @user = User.create!(email: 'abc@example.com', password: '123456', name: 'Example')
      post = Post.create!(user_id: @user.id, content: 'adskcascascsaicaccscxisahxsa')

      expect(post.valid?).to be true
    end

    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(1000).with_long_message('1000 characters in post is the maximum allowed.') }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
