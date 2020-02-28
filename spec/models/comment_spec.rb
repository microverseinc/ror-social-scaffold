require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  let(:user1) do
    User.create(
      name: 'john',
      email: 'john@gmail.com',
      password: 'password'
    )
  end

  let(:user2) do
    User.create(
      name: 'jane',
      email: 'jane@gmail.com',
      password: 'password'
    )
  end

  let(:post) do
    Post.create(
      content: 'This is a new post',
      user_id: user1.id
    )
  end

  it 'gets created with valid params' do
    expect do
      post.comments.create(user_id: user2.id, content: "Jane's comment")
    end.to change(post.comments, :count).by(1)

    expect do
      post.comments.create(user_id: user1.id, content: "John's comment")
    end.to change(post.comments, :count).by(1)
  end

  it 'gets not created with invalid params' do
    expect do
      post.comments.create(user_id: -1, content: "Nobody's comment")
    end.to change(post.comments, :count).by(0)

    expect do
      post.comments.create(user_id: user2.id, content: '')
    end.to change(post.comments, :count).by(0)

    expect do
      post.comments.create(user_id: -1, content: '')
    end.to change(post.comments, :count).by(0)

    expect do
      post.comments.create(user_id: user2.id, content: 'a' * 201)
    end.to change(post.comments, :count).by(0)
  end
end
