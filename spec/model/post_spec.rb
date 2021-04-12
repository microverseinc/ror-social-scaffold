require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(content: 'Content of an amazing post') }
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end
  it 'is not valid without a name' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
  it 'is not valid with a content post being too long' do
    subject.content = 'a' * 1001
    expect(subject).to_not be_valid
  end
  it 'should have many comments' do
    t = Post.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end
  it 'should have many likes' do
    t = Post.reflect_on_association(:likes)
    expect(t.macro).to eq(:has_many)
  end
  it 'should belongs to user' do
    Post.reflect_on_association(:User)
  end
end
