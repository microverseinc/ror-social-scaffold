require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  let(:user1) { User.create(
    name: "john",
    email: "john@gmail.com",
    password: "password"
  ) }

  let(:user2) { User.create(
    name: "jane",
    email: "jane@gmail.com",
    password: "password"
  ) }

  let(:post) { Post.create(
    content: "This is a new post",
    user_id: user1.id
  )}

  it 'gets created with valid params' do
    expect {
      post.comments.create(user_id: user2.id, content: "Jane's comment")
    }.to change(post.comments, :count).by(1)

    expect {
      post.comments.create(user_id: user1.id, content: "John's comment")
    }.to change(post.comments, :count).by(1)
  end

  it 'gets not created with invalid params' do
    expect {
      post.comments.create(user_id: -1, content: "Nobody's comment")
    }.to change(post.comments, :count).by(0)

    expect {
      post.comments.create(user_id: user2.id, content: "")
    }.to change(post.comments, :count).by(0)

    expect {
      post.comments.create(user_id: -1, content: "")
    }.to change(post.comments, :count).by(0)

    expect {
      post.comments.create(user_id: user2.id, content: "a" * 201)
    }.to change(post.comments, :count).by(0)
  end
end