# rubocop:disable Layout/LineLength
require 'rails_helper'

describe Post, type: :model do
  let(:user) { User.create(name: 'test', password: 'testing', email: 'email@email.com') }
  subject { Post.new(user_id: user.id) }

  context 'validations' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content).is_at_most(1000).with_long_message('1000 characters in post is the maximum allowed.')
    }
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
# rubocop:enable Layout/LineLength
