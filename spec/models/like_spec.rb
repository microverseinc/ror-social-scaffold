require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user3 = User.create!(id: 98, name: 'maya', email: 'maya@gmail.com', password: '123456',
                          password_confirmation: '123456')
    @post = Post.create(user_id: @user3.id, content: 'Hello world')
    @like = Like.create(post_id: @post.id, user_id: @user3.id)
  end

  it 'should have valid attributes' do
    expect(@like).to be_valid
  end

  it 'should not be valid without post id' do
    like = Like.new(post_id: nil)
    expect(like).to_not be_valid
  end

  it 'counts the number of post likes' do
    like = Like.count
    expect(like).to be_a_kind_of(Integer)
  end

  it 'should find like by user id' do
    expect(Like.find_by(user_id: 98)).to eq(@like)
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Associations' do
    it { should belong_to(:post) }
  end
end
