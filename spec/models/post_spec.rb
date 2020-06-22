require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations' do
    # Content
    it { should validate_presence_of(:content) }

    it {
      should validate_length_of(:content).is_at_most(1000)
        .with_message('1000 characters in post is the maximum allowed.')
    }

    body = (0..1000).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(body).for(:content) }

    it { should_not allow_value('').for(:content) }
  end

  describe 'Post' do
    # User
    it { should belong_to(:user) }

    # Comments
    it { should have_many(:comments).dependent(:destroy) }

    # Likes
    it { should have_many(:likes).dependent(:destroy) }
  end
end
