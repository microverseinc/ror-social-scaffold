require './rails_helper'

RSpec.describe Post do
  let(:user) { User.create(name: 'elisha', email: 'elisha@gmail.com', encypted_pasword: 'elishapassword') }
  
  context 'An post is created by a user' do
    it 'returns false when post does not have user_id' do
      post = Post.new
      
      post.content = 'What a nice party'
      expect(event.valid?).to be false
    end
    it 'returns true when post has an assosciated user or user_id' do
      post = Post.new
      
      post.user_id = user.id 
      post.content = 'Hey the party'
      
      expect(event.valid?).to be true
    end
  end
  context 'validates presence of required fields' do
    it 'returns false when post content is not present' do
      post = Post.new
      post.user_id = user.id

      expect(post.valid?).to be false
    end
    it 'returns true when post content is present' do
        post = Post.new
        post.user_id = user.id
        post.content = 'jsfh asfjl'
        expect(post.valid?).to be true
    end
  end

  context "with 2 or more comments" do
    it "orders them in reverse chronologically" do
      post = Post.create!
      comment1 = post.comments.create!(:body => "first comment")
      comment2 = post.comments.create!(:body => "second comment")
      expect(post.reload.comments).to eq([comment2, comment1])
    end
  end
end