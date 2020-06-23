require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user1) do
    User.create(name: 'Test',
                email: 'test@mail.com',
                password: 'password',
                password_confirmation: 'password')
  end

  let(:post1) do
    user1.posts.create(content: 'Test')
  end

  let(:like1) do
    user1.likes.create(post_id: 1)
  end

  it 'belongs_to user' do
    expect(like1).to eq(user1.likes.first)
  end

  describe 'associations' do
    it { should belong_to(:user) }

    it { should belong_to(:post) }
  end
end
