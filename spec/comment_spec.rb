# rubocop:disable Layout/LineLength
require 'rails_helper'

describe Comment, type: :model do
  let(:user) { User.create(name: 'test', password: 'testing', email: 'email@email.com') }
  let(:post) { Post.create(user_id: user.id, content: 'Lorem') }
  subject { Comment.new(post_id: post.id, user_id: user.id, content: 'Lorem') }

  context 'validations' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content).is_at_most(200).with_long_message('200 characters in comment is the maximum allowed.')
    }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
# rubocop:enable Layout/LineLength
