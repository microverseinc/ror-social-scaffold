require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { User.create(name:'user_tes1', email:'mail1@mail.com', password: 'password') } 
  let(:user2) { User.create(name:'user_test2', email:'mail2@mail.com', password: 'password') } 
  let(:user3) { User.create(name:'user_test3', email:'mail2@mail.com', password: 'password') } 
  let(:invalid_user) { User.create(name:nil, email:'mail3@mail.com', password: 'password') }
  let(:post_1) { user1.posts.create(content: "Post test")}
  let(:comment_1 ) { Comment.new(content: "Test comment") }

  describe 'An User can be created it has all the validations' do
    it 'Has email, name and password' do
      expect(user1).to be_valid
    end
    it "Is invalid if name, email or password are not present" do
      expect(invalid_user).to_not be_valid 
    end 
  end

  describe 'An user' do
      it 'can create a post if it has content' do
        post = user1.posts.new(content: "test")
        post.save
        expect(post).to be_valid
        post = user1.posts.new()
        post.save
        expect(post).to_not be_valid 
      end
      it 'can comment post'do
        comment_1.user = user1;
        post_1.comments << comment_1
        post_1.save
        expect(post_1).to be_valid
      end
      it 'can Like post'do

        like = Like.new(user: user1, post: post_1)
        expect(like).to be_valid
      end

  end

end
