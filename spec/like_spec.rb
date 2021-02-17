require 'rails_helper'

describe Like, type: :model do
  let(:user) { User.create(name: 'test', password: 'testing', email: 'email@email.com') }
  let(:post) { Post.create(user_id: user.id, content: 'Lorem') }
  subject { Like.new(post_id: post.id, user_id: user.id) }

  context 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:post_id) }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
