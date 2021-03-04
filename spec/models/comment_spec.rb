# rubocop:disable Metrics/BlockLength:
require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations tests' do
    let(:user_params) do
      { name: 'user', email: 'user@email.com', password: 'UseRQWERty' }
    end
    let(:post_params) do
      { content: 'Lorem ipsum dolor sit amet, consectetur
                                      adipiscing' }
    end

    it 'ensures content presence' do
      user = User.new(user_params)
      user.save

      post = Post.new(post_params)
      post.user = user
      post.save

      comment = Comment.new
      comment.post = post
      comment.user = user

      expect(comment.valid?).to eq(false)
    end

    it 'ensures content presence' do
      user = User.new(user_params)
      user.save
      post = Post.new(post_params)
      post.user = user
      post.save
      comment = Comment.new(content: 'lorem ipsum')
      comment.post = post
      comment.user = user
      comment.save
      expect(comment.valid?).to eq(true)
    end

    it 'ensures content lenght to be maximum 200' do
      user = User.new(user_params)
      user.save
      post = Post.new(post_params)
      post.user = user
      post.save
      comment = Comment.new(content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                      Morbi molestie lobortis diam, ac luctus massa lacinia non.
                                      Curabitur cursus elementum sem, fermentum porta lectus tristique sed.
                                       Phasellus vitae bibendum sapien.')
      comment.post = post
      comment.user = user
      comment.save
      expect(comment.valid?).to eq(false)
    end

    it 'ensures content length to be maximum 200' do
      user = User.new(user_params)
      user.save
      post = Post.new(post_params)
      post.user = user
      post.save
      comment = Comment.new(content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                                      Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur.')
      comment.post = post
      comment.user = user
      comment.save
      expect(comment.valid?).to eq(true)
    end
  end
  context 'Association' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
# rubocop:enable Metrics/BlockLength:
