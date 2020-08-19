require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  context 'Validations' do
    let(:user) { User.create(email: 'jttj@gmail.com', name: 'juoe', password: 'joiuyu76run3jdws') }
    let(:post) { user.posts.build(content: 'life is beautiful') }

    it 'valid for post with 1000 characters or less' do
      expect(post).to be_valid
    end

    it 'invalid for post with more than 1000 characters' do
      post.content = (0...1001).map { ('a'..'z') }.join
      expect(post).to_not be_valid
    end

    it { should validate_presence_of(:content) }
  end
end
