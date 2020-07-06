require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  context 'creating comment' do
    it 'content cannot be blank ' do
      expect { Comment.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'checking user who commented' do
    let(:user) { User.create(name: 'Jar Jar', email: '123@email.com', password: '123456') }
    let(:post) { Post.create(content: 'Bla bla', user_id: user.id) }
    let(:comment) { Comment.create(content: 'Test', post_id: post.id, user_id: user.id) }

    it 'user who commented should be Jar Jar' do
      expect(comment.user.name).to eql('Jar Jar')
    end
  end

  context 'testing associations' do
    it 'should have one user' do
      c = Comment.reflect_on_association(:user)
      expect(c.macro).to eq(:belongs_to)
    end
    it 'should have one post' do
      c = Comment.reflect_on_association(:post)
      expect(c.macro).to eq(:belongs_to)
    end
  end
end
