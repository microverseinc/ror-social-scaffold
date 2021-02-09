require './rails_helper'

RSpec.describe Comment do
    let(:user) { User.create(name: 'name of user', email: 'user@example.com', password: 'user123') }
    let(:post) { Post.create(content: 'This is content of the post', user_id: user.id) }
    let(:subject) do
      described_class.new(
        post_id: post.id,
        user_id: user.id,
        content: 'This is a the comment of the post'
      )
    end
  
    describe 'validations' do
      it { is_expected.to validate_presence_of(:content) }
  
      it 'The content of the comment length < 200' do
        subject.content = 't' * 205
        expect(subject).not_to be_valid
      end

      it 'The content of the comment length < 200' do
        subject.content = 't' * 100
        expect(subject).to be_valid
      end
    end
  
    describe 'Associations', type: :model do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to belong_to(:post) }

      it 'returns the post which the comment belongs to' do
        expect(comment.post).to eql(post)
      end 
      it 'returns the user which the comment belongs to' do
        expect(comment.post.user).to eql(user)
      end
    end

    context 'with 2 or more comments' do
        it 'orders them in reverse chronologically' do
          post = Post.create!
          comment1 = post.comments.create!(body: 'first comment')
          comment2 = post.comments.create!(body: 'second comment')
          expect(post.reload.comments).to eq([comment2, comment1])
        end
    end
  end
  
