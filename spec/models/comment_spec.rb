require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Associations' do
    let(:user) { User.new }
    let(:post) { Post.new }
    let(:comment) { Comment.create }
    describe 'associations' do
      it { should belong_to(:user) }
      it { should belong_to(:post) }
    end

    describe 'Validations' do
      it { should validate_presence_of(:content) }
    end
  end
end
