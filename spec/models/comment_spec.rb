require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:all) do
    @user4 = User.create!(id: 97, name: 'user4', email: 'user4@gmail.com', password: '123456',
                          password_confirmation: '123456')
    @user5 = User.create!(id: 96, name: 'user5', email: 'user5@gmail.com', password: '123456',
                          password_confirmation: '123456')
    @post = Post.create(user_id: @user4.id, content: 'I really need this tests to pass :)')
    @comment = Comment.create(user_id: @user5.id, post_id: @post.id, content: 'okay dude!')
  end

  it 'should have valid attributes' do
    expect(@comment).to be_valid
  end

  it 'should not be valid without post id' do
    comment = Comment.new(post_id: nil)
    expect(comment).to_not be_valid
  end

  it 'counts the number of post comments' do
    comment = Comment.count
    expect(comment).to be_a_kind_of(Integer)
  end

  it 'should find comment by user id' do
    expect(Comment.find_by(user_id: 96)).to eq(@comment)
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Associations' do
    it { should belong_to(:post) }
  end
end
