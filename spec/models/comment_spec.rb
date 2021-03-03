require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validations tests" do
   let(:user_params) { { name:'user', email:'user@email.com', password:'UseRQWERty' } }

    it 'ensures content presence' do
      user = User.new(user_params)
      user.save

      post = Post.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vita')
      post.user = user
      post.save

      comment = Comment.new()
      comment.post = post
      comment.user = user

      expect(comment.valid?).to eq(false) 
    end

    it 'ensures content presence' do
      user = User.new(name:'user', email:'user@email.com', password:'UseRQWERty')
      user.save
      post = Post.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vita')
      post.user = user
      post.save
      comment = Comment.new(content:'lorem ipsum')
      comment.post = post
      comment.user = user
      comment.save
      expect(comment.valid?).to eq(true)  
    end

    it 'ensures content lenght to be maximum 200' do
      user = User.new(name:'user', email:'user@email.com', password:'UseRQWERty')
      user.save
      post = Post.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vita')
      post.user = user
      post.save
      comment = Comment.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vitae bibendum sapien.')
      comment.post = post
      comment.user = user
      comment.save
      expect(comment.valid?).to eq(false) 
    end

    it 'ensures content lenght to be maximum 200' do
      user = User.new(name:'user', email:'user@email.com', password:'UseRQWERty')
      user.save
      post = Post.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vita')
      post.user = user
      post.save
      comment = Comment.new(content:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi molestie lobortis diam, ac luctus massa lacinia non. Curabitur cursus elementum sem, fermentum porta lectus tristique sed. Phasellus vit.')
      comment.post = post
      comment.user = user
      comment.save
      expect(comment.valid?).to eq(true) 
    end
  end
  
end
