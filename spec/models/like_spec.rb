require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  context 'creating like' do
    let(:user) { User.create(name: 'Jar Jar', email: '123@email.com', password: '123456') }
    let(:post) { Post.create(content: 'Bla bla', user_id: user.id) }
    let(:like_1) { Like.create(post_id: post.id, user_id: user.id) }
    let(:like_2) { Like.create!(post_id: 1, user_id: 1) }

    it 'user_id has to be unique' do
      expect { like_2 }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'liked post content to be Bla bla' do
      expect(like_1.post.content).to eql('Bla bla')
    end
  end

  context 'testing associations' do
    it 'should have one user' do
      l = Like.reflect_on_association(:user)
      expect(l.macro).to eq(:belongs_to)
    end
    it 'should have one post' do
      l = Like.reflect_on_association(:post)
      expect(l.macro).to eq(:belongs_to)
    end
  end
end
