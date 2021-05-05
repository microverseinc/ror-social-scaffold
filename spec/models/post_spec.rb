require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user2 = User.create!(id: 99, name: 'henda', email: 'henda@gmail.com', password: '123456',
                          password_confirmation: '123456')
    @post = Post.create(user_id: @user2.id, content: 'Hello world')
    @like = Like.create(post_id: @post.id, user_id: @user2.id)
  end

  it 'should have valid attributes' do
    expect(@post).to be_valid
  end

  it 'should not be valid without user id' do
    post = Post.new(user_id: nil)
    expect(post).to_not be_valid
  end

  it 'should find post user id' do
    expect(Post.find_by(user_id: 99)).to eq(@post)
  end

  describe 'Associations' do
    it { should have_many(:likes) }
  end

  describe 'Associations' do
    it { should have_many(:comments) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
