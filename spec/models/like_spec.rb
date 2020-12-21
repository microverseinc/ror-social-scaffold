require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) do
    User.create(name: 'User test like', email: 'user@gmail.com',
                password: 'password', password_confirmation: 'password')
  end
  let(:post) do
    Post.create(user_id: user.id, content: 'this is a test post for like purpose')
  end
  subject { described_class.new(user_id: user.id, post_id: post.id) }

  it 'is valid with the correct attributes' do
    expect(subject).to be_valid
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
