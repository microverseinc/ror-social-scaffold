require_relative '../rails_helper'

RSpec.describe User, type: :model do
  context 'creating user' do
    it 'name cannot be blank ' do
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'User can create content' do
    let(:user) { User.create(name: 'Jar Jar', email: '123@email.com', password: '123456') }
    let(:post) { Post.create(content: 'Bla bla', user_id: user.id) }
    let(:comment) { Comment.create(content: 'Test', post_id: post.id, user_id: user.id) }
    it 'post have content Bla bla' do
      expect(post.content).to eql('Bla bla')
    end
    it 'comment has text Test' do
      expect(comment.content).to eql('Test')
    end
  end

  context 'testing associations' do
    it 'should have many posts' do
      u = User.reflect_on_association(:posts)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many comments' do
      u = User.reflect_on_association(:comments)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many likes' do
      u = User.reflect_on_association(:likes)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many friendships' do
      u = User.reflect_on_association(:friendships)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many inverse friendships' do
      u = User.reflect_on_association(:inverse_friendships)
      expect(u.macro).to eq(:has_many)
    end
  end
end
