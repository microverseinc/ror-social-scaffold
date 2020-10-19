require 'rails_helper'

RSpec.describe Post, type: :model do
  context "Validation test" do
    it 'cannot be empty' do
      post = Post.new(content: '').save
      expect(post).to eq(false)
    end

    it 'maximum characters is 1000' do
      post = 't'*1000
      post0 = Post.new(content: post).save
      expect(post0).to eq(false)
    end

    it "must have a user" do
     post1 = Post.new(content:'must have a user').save
     expect(post1).to eq(false)
    end
  end
end
