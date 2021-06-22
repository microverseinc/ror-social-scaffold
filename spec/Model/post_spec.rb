require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'belong to user' do
    t = Post.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'should have many comments' do
    t = Post.reflect_on_association(:comments)
    expect(t.macro).to eq(:has_many)
  end

  it 'should have many likes' do
    t = Post.reflect_on_association(:likes)
    expect(t.macro).to eq(:has_many)
  end
end
