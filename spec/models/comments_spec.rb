require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
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
      subject.content = 'This is a validation comment'
      expect(subject).to be_valid
    end

    it 'is not valid without content' do
      subject.content = ''
      expect(subject).to_not be_valid
    end

    context 'testing associations Comments' do
      it 'belongs to user' do
        x = Comment.reflect_on_association(:user)
        expect(x.macro).to eq(:belongs_to)
      end
      it 'belongs to post' do
        x = Comment.reflect_on_association(:post)
        expect(x.macro).to eq(:belongs_to)
      end
    end
  end
end
