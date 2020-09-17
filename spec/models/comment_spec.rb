require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Validations' do
    let(:user) { User.create(name: 'Rebecca Y', email: 'recca@opal.com', password: 'itsG00d2Have$') }
    let(:post) { Post.create(user_id: user.id, content: 'I am the world!') }
    subject { post.comments.build(user_id: user.id, content: 'Yes, I am') }

    it 'should have a content not more than 200 characters' do
      expect(subject).to be_valid
    end

    it { expect(subject).to validate_presence_of(:content) }

    it {
      expect(subject).to validate_length_of(:content).is_at_most(200)
        .with_message(/200 characters in comment is the maximum allowed./)
    }
  end

  context 'Association' do
    it { expect(subject).to belong_to(:user) }
    it { expect(subject).to belong_to(:post) }
  end
end
