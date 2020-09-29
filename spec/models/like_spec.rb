require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'validations' do
    let(:user) do
      User.create(name: 'Magz',
                  email: 'magz@example.com',
                  password: '123456',
                  password_confirmation: '123456')
    end

    let(:user1) do
      User.create(name: 'Jocy',
                  email: 'jocy@example.com',
                  password: '123456',
                  password_confirmation: '123456')
    end

    let(:post) { Post.create(user_id: user1.id, content: 'This is my first post') }

    it 'is valid with all fields valid' do
      subject.user_id = user1.id
      subject.post_id = post.id
      expect(subject).to be_valid
    end

    it 'is not valid without post_id' do
      subject.user_id = user1.id
      expect(subject).to_not be_valid
    end

    it 'is not valid without user_id' do
      subject.post_id = post.id
      expect(subject).to_not be_valid
    end
  end

  context 'testing associations Likes' do
    it 'belongs to user' do
      x = Like.reflect_on_association(:user)
      expect(x.macro).to eq(:belongs_to)
    end
    it 'belongs to post' do
      x = Like.reflect_on_association(:post)
      expect(x.macro).to eq(:belongs_to)
    end
  end
end
