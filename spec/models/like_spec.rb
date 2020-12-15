require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Association Test' do
    it 'belongs to users' do
      expect(Like.reflect_on_association(:user).macro).to be :belongs_to
    end

    it 'belongs to posts' do
      expect(Like.reflect_on_association(:post).macro).to be :belongs_to
    end
  end
end
