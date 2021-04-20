require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Post' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end
end
