require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    # Content
    it { should validate_presence_of(:content) }

    it {
      should validate_length_of(:content).is_at_most(200)
        .with_message('200 characters in comment is the maximum allowed.')
    }

    body = (0..200).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(body).for(:content) }

    it { should_not allow_value('').for(:content) }
  end

  describe 'Comment' do
    # User
    it { should belong_to(:user) }

    # Post
    it { should belong_to(:post) }
  end
end
