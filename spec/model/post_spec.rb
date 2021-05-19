require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation test' do
    it { should validate_presence_of(:content) }

    it do
      should validate_length_of(:content)
        .is_at_most(1000)
        .with_message('1000 characters in post is the maximum allowed.')
    end

    it 'should save successfully' do
      post1 = Post.new(content: 'Test content', user_id: 1).save
      expect(post1) == true
    end
  end
end
