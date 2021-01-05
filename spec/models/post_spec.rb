require 'rails_helper'
require './app/models/post.rb'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }

    
  end

  describe 'validation' do
    it {
      should(
        validate_length_of(:content)
          .is_at_most(1000)
          .with_long_message('1000 characters in post is the maximum allowed.')
      )
    }
    it { should validate_presence_of(:content) }
  end
end

