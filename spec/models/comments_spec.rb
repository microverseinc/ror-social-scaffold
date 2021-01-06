require 'rails_helper'

RSpec.describe Comment do
  let(:user) { User.create(name: 'User', email: 'user@user.com', password: '123456') }
  let(:post) { Post.create(content: 'This is some content.', user_id: user.id) }
  let(:subject) { described_class.new(user_id: user.id, post_id: post.id, content: 'This is a comment') }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
  end

  describe 'associations', type: :model do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:post)}
  end
end
