require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Rebecca Y', email: 'recca@opal.com', password: 'itsG00d2Have$') }

  before do
    Post.create(user_id: user.id, content: 'I am the world!')
    Post.create(user_id: user.id, content: 'Here I am')
  end
  context 'Validations' do
    it { expect(subject).to validate_presence_of(:content) }
    it {
      expect(subject).to validate_length_of(:content).is_at_most(1000)
        .with_message(/1000 characters in post is the maximum allowed./)
    }
  end
  context 'Associations' do
    it { expect(subject).to belong_to :user }
    it { expect(subject).to have_many(:comments).dependent(:destroy) }
    it { expect(subject).to have_many(:likes).dependent(:destroy) }
  end

  context 'Scope' do
    it { expect(Post.ordered_by_most_recent.first).to eq(Post.last) }
  end
end
