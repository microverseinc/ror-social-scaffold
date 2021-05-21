require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'is associated to user, comments and likes' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'is valid with valid attributes' do
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content)
        .is_at_most(1000)
        .with_long_message('1000 characters in post is the maximum allowed.')
    }
  end
end
