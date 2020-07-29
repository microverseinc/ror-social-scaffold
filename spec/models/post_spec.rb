require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  context 'creating post' do
    it 'content cannot be blank ' do
      expect { Post.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'checking user who post' do
    let(:user) { User.create(name: 'Jar Jar', email: '123@email.com', password: '123456') }
    let(:post) { Post.create(content: 'Bla bla', user_id: user.id) }
    it 'user who posted is Jar' do
      expect(post.user.name).to eql('Jar Jar')
    end
  end

  context 'testing associations' do
    it 'should have one user' do
      po = Post.reflect_on_association(:user)
      expect(po.macro).to eq(:belongs_to)
    end
    it 'should have many comments' do
      po = Post.reflect_on_association(:comments)
      expect(po.macro).to eq(:has_many)
    end
    it 'should have many likes' do
      po = Post.reflect_on_association(:likes)
      expect(po.macro).to eq(:has_many)
    end
  end
end
