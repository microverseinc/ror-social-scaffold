require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { Post.new(content: 'A simple post content') }

  it 'has to have a content' do
    expect(post.content).to eq('A simple post content')
  end
  it 'returns an error for missing content' do
    post.content = nil
    expect(post.save).to eq(false)
  end
end
